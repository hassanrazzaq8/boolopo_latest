import 'package:get_storage/get_storage.dart';

import '/core/app_export.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    var x = GetStorage().read("isIt");
    Future.delayed(const Duration(seconds: 3), () {
      x != null
          ? Get.offNamed(AppRoutes.bottomBarScreen)
          : Get.offNamed(AppRoutes.loginScreen);
    });
    super.onInit();
  }
}
