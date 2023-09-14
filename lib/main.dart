import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:watch_app/presentation/dashboard/checkout/checkout_controller.dart';
import 'package:watch_app/providers/cart_provider.dart';
import 'package:watch_app/providers/favourite_provider.dart';
import 'package:watch_app/routes/app_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LazyBinding().dependencies();
  await GetStorage.init();
  runApp(const MyApp());
}

class LazyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CheckoutController());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoProvider()),
        ChangeNotifierProvider(create: (context) => ProviderCart()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        theme: AppTheme.themeData,
        getPages: AppRoutes.pages,
        defaultTransition: Transition.cupertino,
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          // MonthYearPickerLocalizations.delegate,
        ],
      ),
    );
  }
}
