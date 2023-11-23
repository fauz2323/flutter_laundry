import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:laundry/app/modules/home_screen/views/home_screen_view.dart';
import 'package:laundry/app/modules/in/views/in_view.dart';
import 'package:laundry/app/modules/keuangan/views/keuangan_view.dart';
import 'package:laundry/app/modules/stock/views/stock_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var selectedIndex = 0.obs;
  var listWidget = <Widget>[
    HomeScreenView()..controller.initial(),
    InView(),
    StockView(),
    KeuanganView()
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
