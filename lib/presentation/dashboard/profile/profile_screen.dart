import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/prects.dart';
import 'package:watch_app/presentation/bottomBar/bottombar_controller.dart';
import 'package:watch_app/presentation/commamn/clip_path.dart';
import 'package:watch_app/presentation/webView/app_web_view.dart';
import 'package:watch_app/utills/storage.dart';
import 'package:coinbase_commerce/coinbase_commerce.dart';
import '../../../core/app_export.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final BottomBarController _barController = Get.find();

  @override
  Widget build(BuildContext context) {
    String username = Storage.readData(AppString.userName) ?? "";
    String email = Storage.readData(AppString.email) ?? "";
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                width: Get.width,
                height: 256,
                color: AppColors.appColor,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(Storage.readData(
                                        AppString.profileImage) !=
                                    null
                                ? Storage.readData(AppString.profileImage)!
                                        .isNotEmpty
                                    ? Storage.readData(AppString.profileImage)!
                                    : "https://sin5.org/images/faces/1.jpg"
                                : "https://sin5.org/images/faces/1.jpg"),
                          ),
                        ),
                      ),
                    ),
                    hSizedBox10,
                    const Text(
                      "Welcome back",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    hSizedBox6,
                    Text(
                        "${Storage.readData(AppString.firstName)} ${Storage.readData(AppString.lastName)}",
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: Get.textScaleFactor * 28,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
            hSizedBox20,
            profileList(
              icon: ImageConstant.buy,
              name: AppString.myCart,
              ontap: () {
                _barController.pageIndex.value = 1;
              },
            ),
            profileList(
              icon: ImageConstant.myOrders,
              name: AppString.myOrders,
              ontap: () {
                Get.toNamed(AppRoutes.myOrdersScreen);
                // Get.to(()=> const Prects());
              },
            ),
            profileList(
              icon: ImageConstant.privacyPolicy,
              name: AppString.privacyPolicy,
              ontap: () {
                Get.to(
                  () => AppWebView(
                    url: "https://boolopo.co/privacy-policy/",
                    title: "Privacy Policy",
                  ),
                );
              },
            ),
            profileList(
              icon: ImageConstant.contactIcon,
              name: AppString.contactus,
              ontap: () {
                Get.toNamed(AppRoutes.contactUsScreen);
              },
            ),
            profileList(
              icon: ImageConstant.aboutUs,
              name: AppString.aboutUs,
              ontap: () {
                Get.to(
                  () => AppWebView(
                      url: "https://boolopo.co/about-us/", title: "About Us"),
                );
              },
            ),
            // TextButton(
            //   onPressed: () async {
            //     ChargeObject image = await coinbase!.createCharge(
            //         name: 'Record Me',
            //         description: 'description',
            //         currency: CurrencyType.usd,
            //         pricingType: PricingType.fixedPrice,
            //         amount: 40);
            //     Get.to(()=> AppWebView(url: image.url!, title: "Coinbase Payment"));
            //
            //   },
            //   child: Text('Create a Charge'),
            // ),
            hSizedBox10,
          ],
        ),
      ),
    );
  }

  GestureDetector profileList({
    required String icon,
    required String name,
    required Function() ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10.0,
              spreadRadius: .5,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              color: Colors.black,
              height: 20,
              width: 30,
            ),
            wSizedBox12,
            Text(
              name,
              style: const TextStyle(
                color: Color(0xff707070),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Image.asset(
              ImageConstant.forwordarrow,
              color: const Color(0xffB5B5B5),
              height: 16,
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
// String apiKey = '';
// Coinbase? coinbase;
// String output = 'Output';
//
//
//
// @override
// void initState() {
//   super.initState();
//   coinbase = Coinbase(apiKey, debug: true);
// }
}
