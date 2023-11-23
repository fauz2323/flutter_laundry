import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_screen/bindings/home_screen_binding.dart';
import '../modules/home_screen/views/home_screen_view.dart';
import '../modules/in/bindings/in_binding.dart';
import '../modules/in/views/in_view.dart';
import '../modules/keuangan/bindings/keuangan_binding.dart';
import '../modules/keuangan/views/keuangan_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/stock/bindings/stock_binding.dart';
import '../modules/stock/views/stock_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      bindings: [
        HomeBinding(),
        HomeScreenBinding(),
        InBinding(),
        StockBinding(),
        KeuanganBinding(),
      ],
    ),
    GetPage(
      name: _Paths.IN,
      page: () => const InView(),
      binding: InBinding(),
    ),
    GetPage(
      name: _Paths.STOCK,
      page: () => const StockView(),
      binding: StockBinding(),
    ),
    GetPage(
      name: _Paths.KEUANGAN,
      page: () => const KeuanganView(),
      binding: KeuanganBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => const HomeScreenView(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
