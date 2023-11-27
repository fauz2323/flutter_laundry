import 'package:get/get.dart';
import 'package:laundry/app/data/modelSql/keuangan_model.dart';
import 'package:laundry/app/data/modelSql/transaction_model.dart';
import 'package:laundry/app/helper/sql_helper.dart';

class HomeScreenController extends GetxController {
  //TODO: Implement HomeScreenController
  final SQLHelper _sqlHelper = SQLHelper();
  var dataKeuangan = <KeuanganModel>[].obs;
  var inOut = <TransactionModel>[].obs;
  var isLoading = true.obs;
  var total = 0.obs;
  var galonMasuk = 0.obs;
  var galonKeluar = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print('object');
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
    galonMasuk.value = 0;
    galonKeluar.value = 0;
    total.value = 0;
    isLoading(true);
    dataKeuangan.value = await _sqlHelper.getAllKeuangan();
    inOut.value = await _sqlHelper.getAllTransaction();
    for (var inOutElemet in inOut) {
      if (inOutElemet.type == 'masuk') {
        galonMasuk.value += inOutElemet.amount;
      } else {
        galonKeluar.value += inOutElemet.amount;
      }
    }

    dataKeuangan.forEach((element) {
      total.value += element.amount;
    });
    print(total.value);

    await Future.delayed(Duration(seconds: 2));

    isLoading(false);
  }

  addData() async {
    await _sqlHelper.a();

    return 'done';
  }
}
