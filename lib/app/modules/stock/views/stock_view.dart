import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../theme/text_style_theme.dart';
import '../../../widget/card_home_widget.dart';
import '../../../widget/card_list_widget.dart';
import '../../../widget/loading_widget.dart';
import '../controllers/stock_controller.dart';

class StockView extends GetView<StockController> {
  const StockView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: "Galon Keluar/Masuk",
            content: Container(
              width: Get.width * 90 / 100,
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Type"),
                  Obx(
                    () => DropdownButton<String>(
                      value: controller.type.value,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        controller.type.value = value!;
                      },
                      items: controller.listType
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Text("Deskripsi"),
                  TextFormField(
                    controller: controller.descController,
                  ),
                  Text("Jumlah"),
                  TextFormField(
                    controller: controller.amountController,
                  ),
                ],
              ),
            ),
            cancel: ElevatedButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            confirm: ElevatedButton(
              onPressed: () => controller.addData(),
              child: Text("Save"),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Data In/Out'),
      ),
      body: Obx(
        () => controller.isLoading.value ? LoadingWidget() : _loaded(context),
      ),
    );
  }

  Widget _loaded(BuildContext context) {
    return Container(
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
                data: controller.totalMasuk.toString(),
                colorData: Colors.amber.withOpacity(0.8),
              ),
              CardHomeWidget(
                width: Get.width * 0.43,
                tittle: "Galon Keluar",
                data: controller.totalKeluar.toString(),
                colorData: Colors.greenAccent.withOpacity(0.8),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          CardHomeWidget(
            width: Get.width * 0.9,
            tittle: "Total Stock Galon",
            data: controller.galonTotal.value.toString(),
            colorData: Colors.cyanAccent.withOpacity(0.8),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'List Galon Keluar/Masuk',
            style: TextStyleThemes.h1,
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: controller.dataStock
                  .map((element) {
                    return CardListWidget(
                      icon: Icons.water,
                      date: element.date,
                      amount: element.amount.toString(),
                      desc: element.desc,
                    );
                  })
                  .toList()
                  .reversed
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
