import 'package:get/get.dart';

import '../controllers/in_controller.dart';

class InBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InController>(
      () => InController(),
    );
  }
}
