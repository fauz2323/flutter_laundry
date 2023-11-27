import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/app/data/modelSql/stock_model.dart';

import '../../../helper/intl_helper.dart';
import '../../../helper/sql_helper.dart';

class StockController extends GetxController {
  //TODO: Implement StockController
  var dataStock = <StockModel>[].obs;
  final SQLHelper _sqlHelper = SQLHelper();
  var isLoading = true.obs;
  var totalMasuk = 0.obs;
  var totalKeluar = 0.obs;
  var galonTotal = 0.obs;

  var type = 'masuk'.obs;
  List<String> listType = ['masuk', 'keluar'];
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initial();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  initial() async {
    isLoading(true);
    dataStock.value = await _sqlHelper.getAllStock();
    for (var element in dataStock) {
      if (element.type == 'masuk') {
        totalMasuk.value += element.amount;
      } else {
        totalKeluar.value += element.amount;
      }
    }

    galonTotal.value = totalMasuk.value - totalKeluar.value;

    isLoading(false);
  }

  addData() async {
    if (descController.text.isEmpty) {
      return Get.snackbar("Error", "tujuan harus diisi");
    }
    if (!amountController.text.isNumericOnly) {
      return Get.snackbar("Message", "masukan angka");
    }
    Get.back();
    isLoading(true);

    StockModel addStock = await _sqlHelper.insertStock(
      StockModel(
        type: type.value,
        desc: descController.text,
        amount: int.parse(amountController.text),
        date: IntlHelper.convertDate(DateTime.now()),
      ),
    );

    if (type.value == 'masuk') {
      totalMasuk += int.parse(amountController.text);
    } else {
      totalKeluar += int.parse(amountController.text);
    }

    galonTotal.value = totalMasuk.value - totalKeluar.value;

    dataStock.add(
      StockModel(
        id: addStock.id,
        type: type.value,
        desc: descController.text,
        amount: int.parse(amountController.text),
        date: IntlHelper.convertDate(
          DateTime.now(),
        ),
      ),
    );
    isLoading(false);
    Get.snackbar("Message", "data Berhasil Di Tambah");
  }

  deleteItem(StockModel data) {
    isLoading(true);

    if (data.type == 'masuk') {
      totalMasuk.value -= data.amount;
      galonTotal.value = totalMasuk.value - totalKeluar.value;
    } else {
      totalKeluar.value -= data.amount;
      galonTotal.value = totalMasuk.value - totalKeluar.value;
    }

    _sqlHelper.deleteStock(data.id!);

    dataStock.removeWhere((element) => element.id == data.id!);

    isLoading(false);
    Get.snackbar("Message", "data Berhasil Di Hapus");
  }
}
