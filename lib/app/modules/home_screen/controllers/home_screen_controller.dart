import 'package:get/get.dart';
import 'package:laundry/app/data/modelSql/keuangan_model.dart';
import 'package:laundry/app/helper/sql_helper.dart';

class HomeScreenController extends GetxController {
  //TODO: Implement HomeScreenController
  final SQLHelper _sqlHelper = SQLHelper();
  var dataKeuangan = <KeuanganModel>[].obs;
  var isLoading = true.obs;
  var total = 0.obs;

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
    dataKeuangan.value = await _sqlHelper.getAllKeuangan();
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
