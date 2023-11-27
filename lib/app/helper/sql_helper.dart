import 'package:laundry/app/data/model/in_out_Model.dart';
import 'package:laundry/app/data/modelSql/stock_model.dart';
import 'package:laundry/app/data/modelSql/transaction_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../data/modelSql/keuangan_model.dart';

class SQLHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await openDb();
    return _db!;
  }

  Future openDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'laundry.db');
    print('open db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // Create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
      await db.execute(
          'CREATE TABLE inOut (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, destination TEXT, amount INTEGER, date TEXT)');
      await db.execute(
          'CREATE TABLE keuangan (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, desc TEXT, amount INTEGER, date TEXT)');
      await db.execute(
          'CREATE TABLE stock (id INTEGER PRIMARY KEY AUTOINCREMENT, amount INTEGER, desc TEXT, date TEXT, type TEXT)');
    });

    return database;
  }

  Future insertTransaction(TransactionModel transaction) async {
    var dbClient = await db;
    transaction.id = await dbClient.insert('inOut', transaction.toMap());
    return transaction;
  }

  Future insertStock(StockModel stock) async {
    var dbClient = await db;
    stock.id = await dbClient.insert('stock', stock.toMap());
    return stock;
  }

  Future insertKeuangan(KeuanganModel keuangan) async {
    var dbClient = await db;
    keuangan.id = await dbClient.insert('keuangan', keuangan.toMap());
    return keuangan;
  }

  Future a() async {
    var dbClient = await db;
    KeuanganModel keuanganModel = KeuanganModel(
        amount: 1000,
        date: '22-10-2022',
        type: 'masuk',
        desc: "Uang dari pembelian galon 3 biji");
    keuanganModel.id = await dbClient.insert('keuangan', keuanganModel.toMap());
    print('ok');
    return keuanganModel;
  }

  Future<InOutModel> getInOutSum() async {
    var dbClient = await db;
    var masukTotal = await dbClient.rawQuery(
        'SELECT SUM(amount) as total FROM keuangan WHERE type = "masuk"');

    var keluarTotal = await dbClient.rawQuery(
        'SELECT SUM(amount) as amount FROM keuangan WHERE type = "keluar"');

    print('mulai');
    print(masukTotal.toList().first['total']);
    print(keluarTotal.first['amount']);

    return InOutModel(masuk: 1, keluar: 2);
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query('inOut',
        columns: ['id', 'type', 'destination', 'amount', 'date']);

    List<TransactionModel> transaction = maps.map((record) {
      return TransactionModel.fromMap(record);
    }).toList();

    return transaction;
  }

  Future<List<KeuanganModel>> getAllKeuangan() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient
        .query('keuangan', columns: ['id', 'type', 'amount', 'date', 'desc']);

    List<KeuanganModel> transaction = maps.map((record) {
      return KeuanganModel.fromMap(record);
    }).toList();

    return transaction;
  }

  Future<List<StockModel>> getAllStock() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient
        .query('stock', columns: ['id', 'type', 'amount', 'date', 'desc']);

    List<StockModel> stock = maps.map((record) {
      return StockModel.fromMap(record);
    }).toList();

    return stock;
  }

  Future deleteTransaction(int id) async {
    var dbClient = await db;
    return await dbClient.delete('inOut', where: 'id = ?', whereArgs: [id]);
  }

  Future deleteStock(int id) async {
    var dbClient = await db;
    return await dbClient.delete('stock', where: 'id = ?', whereArgs: [id]);
  }

  Future deleteKeuangan(int id) async {
    var dbClient = await db;
    return await dbClient.delete('keuangan', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
