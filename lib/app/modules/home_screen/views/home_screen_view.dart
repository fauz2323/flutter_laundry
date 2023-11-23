import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:laundry/app/helper/intl_helper.dart';
import 'package:laundry/app/theme/text_style_theme.dart';
import 'package:laundry/app/widget/loading_widget.dart';

import '../../../widget/card_home_widget.dart';
import '../../../widget/card_list_widget.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.initial(),
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: const Text('Hello, Users'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingWidget()
            : Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardHomeWidget(
                          width: Get.width * 0.43,
                          tittle: "Galon Masuk",
                          data: controller.galonMasuk.value.toString(),
                          colorData: Colors.amber.withOpacity(0.8),
                        ),
                        CardHomeWidget(
                          width: Get.width * 0.43,
                          tittle: "Galon Keluar",
                          data: controller.galonKeluar.value.toString(),
                          colorData: Colors.greenAccent.withOpacity(0.8),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CardHomeWidget(
                      width: Get.width * 0.9,
                      tittle: "Keuangan Bulan Ini",
                      data: IntlHelper.convertToRupiah(controller.total.value),
                      colorData: Colors.cyanAccent.withOpacity(0.8),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("History Keuangan", style: TextStyleThemes.h1),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: controller.dataKeuangan
                            .map(
                              (element) => CardListWidget(
                                type: element.type,
                                desc: element.desc,
                                date: element.date,
                                amount:
                                    IntlHelper.convertToRupiah(element.amount),
                                icon: Icons.money,
                              ),
                            )
                            .toList()
                            .reversed
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
