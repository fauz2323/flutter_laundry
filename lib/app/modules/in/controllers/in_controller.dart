import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/app/data/modelSql/transaction_model.dart';
import 'package:laundry/app/helper/intl_helper.dart';

import '../../../helper/sql_helper.dart';

class InController extends GetxController {
  //TODO: Implement InController
  var dataTransaksi = <TransactionModel>[].obs;
  final SQLHelper _sqlHelper = SQLHelper();
  var isLoading = true.obs;
  var totalMasuk = 0.obs;
  var totalKeluar = 0.obs;

  var type = 'masuk'.obs;
  List<String> listType = ['masuk', 'keluar'];
  final TextEditingController amountController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

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
    dataTransaksi.value = await _sqlHelper.getAllTransaction();
    for (var element in dataTransaksi) {
      if (element.type == 'masuk') {
        totalMasuk.value += element.amount;
      } else {
        totalKeluar.value += element.amount;
      }
    }
    isLoading(false);
  }

  addData() async {
    if (destinationController.text.isEmpty) {
      return Get.snackbar("Error", "tujuan harus diisi");
    }
    if (!amountController.text.isNumericOnly) {
      return Get.snackbar("Message", "masukan angka");
    }
    Get.back();
    isLoading(true);

    TransactionModel addIn = await _sqlHelper.insertTransaction(
      TransactionModel(
        type: type.value,
        destination: destinationController.text,
        amount: int.parse(amountController.text),
        date: IntlHelper.convertDate(DateTime.now()),
      ),
    );

    if (type.value == 'masuk') {
      totalMasuk += int.parse(amountController.text);
    } else {
      totalKeluar += int.parse(amountController.text);
    }

    dataTransaksi.add(
      TransactionModel(
        id: addIn.id,
        type: type.value,
        destination: destinationController.text,
        amount: int.parse(amountController.text),
        date: IntlHelper.convertDate(
          DateTime.now(),
        ),
      ),
    );
    isLoading(false);
    Get.snackbar("Message", "data Berhasil Di Upload");
  }

  deleteItem(TransactionModel data) {
    isLoading(true);

    if (data.type == 'masuk') {
      totalMasuk.value -= data.amount;
    } else {
      totalKeluar.value -= data.amount;
    }

    _sqlHelper.deleteTransaction(data.id!);

    dataTransaksi.removeWhere((element) => element.id == data.id!);

    isLoading(false);
    Get.snackbar("Message", "data Berhasil Di Hapus");
  }
}
