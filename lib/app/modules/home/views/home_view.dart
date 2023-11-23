import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
          child:
              controller.listWidget.elementAt(controller.selectedIndex.value),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            elevation: 18,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.autorenew),
                label: 'In/Out',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart),
                label: 'Stock',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.money),
                label: 'Keuangan',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Colors.blue,
            backgroundColor: Color.fromARGB(126, 233, 233, 233),
            unselectedItemColor: Colors.black,
            onTap: controller.onItemTapped,
          )),
    );
  }
}
