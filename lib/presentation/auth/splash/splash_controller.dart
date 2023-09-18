import 'package:get_storage/get_storage.dart';
import 'package:watch_app/utills/storage.dart';

import '/core/app_export.dart';

class SplashController extends GetxController {
  @override
  void onInit() {

    Future.delayed(const Duration(seconds: 3), () {
     Storage.isUserLogin
          ? Get.offNamed(AppRoutes.bottomBarScreen)
          : Get.offNamed(AppRoutes.loginScreen);
    });
    super.onInit();
  }
}
