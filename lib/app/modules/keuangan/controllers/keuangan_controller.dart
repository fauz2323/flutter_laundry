import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/app/data/modelSql/keuangan_model.dart';

import '../../../helper/intl_helper.dart';
import '../../../helper/sql_helper.dart';

class KeuanganController extends GetxController {
  //TODO: Implement KeuanganController

  var dataKeuangan = <KeuanganModel>[].obs;
  final SQLHelper _sqlHelper = SQLHelper();
  var isLoading = true.obs;
  var totalMasuk = 0.obs;
  var totalKeluar = 0.obs;
  var keuanganTotal = 0.obs;

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
    dataKeuangan.value = await _sqlHelper.getAllKeuangan();
    for (var element in dataKeuangan) {
      if (element.type == 'masuk') {
        totalMasuk.value += element.amount;
      } else {
        totalKeluar.value += element.amount;
      }
    }

    keuanganTotal.value = totalMasuk.value - totalKeluar.value;

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

    KeuanganModel addKeuangan = await _sqlHelper.insertKeuangan(
      KeuanganModel(
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

    keuanganTotal.value = totalMasuk.value - totalKeluar.value;

    dataKeuangan.add(
      KeuanganModel(
        id: addKeuangan.id,
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

  deleteItem(KeuanganModel data) {
    isLoading(true);

    if (data.type == 'masuk') {
      totalMasuk.value -= data.amount;
      keuanganTotal.value = totalMasuk.value - totalKeluar.value;
    } else {
      totalKeluar.value -= data.amount;
      keuanganTotal.value = totalMasuk.value - totalKeluar.value;
    }

    _sqlHelper.deleteKeuangan(data.id!);

    dataKeuangan.removeWhere((element) => element.id == data.id!);

    isLoading(false);
    Get.snackbar("Message", "data Berhasil Di Hapus");
  }
}
