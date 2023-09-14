import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/auth/login/login_screen.dart';
import 'package:watch_app/presentation/dashboard/favorite/favorite_screen.dart';
import 'package:watch_app/presentation/dashboard/home/home_page.dart';
import 'package:watch_app/presentation/dashboard/profile/profile_screen.dart';
import 'package:watch_app/presentation/dashboard/shopping_cart/my_cart.dart';
import 'package:watch_app/utills/color.dart';

import '../commamn/app_bar.dart';
import '../commamn/app_dialog.dart';
import 'bottombar_controller.dart';

import '../../core/app_export.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({Key? key}) : super(key: key);
  final BottomBarController _con = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    var y = GetStorage().read("isIt") ?? "true";
    return Obx(
      () => Scaffold(
        drawer: drawerOpen(),
        key: _con.scaffoldKey,
        appBar: _con.pageIndex.value == 0
            ? appBar(
                text: "BOO--LOPO",
                leadingPressed: () {
                  _con.openDrawer();
                },
                back: false,
                actionIcon: true,
                action: ImageConstant.notification,
                search: true,
              )
            : _con.pageIndex.value == 1
                ? appBar(
                    text: AppString.shoppingCart,
                    back: false,
                    actionIcon: true,
                    leadingPressed: () {
                      _con.openDrawer();
                    },
                  )
                : _con.pageIndex.value == 2
                    ? appBar(
                        text: AppString.favorite,
                        back: false,
                        actionIcon: true,
                        leadingPressed: () {
                          _con.openDrawer();
                        },
                      )
                    : appBar(
                        actionPressed: () {
                          Get.toNamed(AppRoutes.editProfileScreen);
                        },
                        backgroundColor: AppColors.appColor,
                        action: ImageConstant.editprofile,
                        text: AppString.profile,
                        back: false,
                        actionIcon: true,
                        leadingPressed: () {
                          _con.openDrawer();
                        },
                      ),
        body: _con.pageIndex.value == 0
            ? const HomePage()
            : _con.pageIndex.value == 1
                ? const Cart()
                : _con.pageIndex.value == 2
                    ? const FavoriteScreen()
                    : _con.pageIndex.value == 3
                        ? y != null
                            ? ProfileScreen()
                            : const LoginScreen()
                        : const HomePage(),
        bottomNavigationBar: bottombar(),
      ),
    );
  }

  bottombar() {
    return Container(
      height: Get.height * 0.12,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 0.1),
          )
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _con.icons.length,
            (index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _con.pageIndex.value == index
                        ? AppColors.backgroundColor
                        : null,
                  ),
                  child: IconButton(
                    onPressed: () => _con.onTap(index),
                    icon: Image.asset(
                      _con.icons[index],
                      color: _con.pageIndex.value == index
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawerOpen() {
    var x = GetStorage().read("isIt");
    String username = GetStorage().read("username");
    String email = GetStorage().read("userEmail");
    return Drawer(
      backgroundColor: AppColors.appColor,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.1),
                Center(
                  child: Container(
                    height: Get.height * .15,
                    width: Get.height * .15,
                    decoration: const BoxDecoration(),
                    child: Image.asset(
                      ImageConstant.appLogo,
                    ),
                  ),
                ),
                hSizedBox36,
                const Divider(
                  color: Colors.white,
                  thickness: 1.5,
                ),
                hSizedBox36,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _con.drawerList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _con.drawerIndex.value = index;
                        _con.drawerIndex.value == 0
                            ? Get.toNamed(AppRoutes.orderSummaryScreen)
                            : _con.drawerIndex.value == 1
                                ? Get.toNamed(AppRoutes.inviteFriendScreen)
                                : _con.drawerIndex.value == 2
                                    ? Get.toNamed(AppRoutes.paymentScreen)
                                    : _con.drawerIndex.value == 3
                                        ? Get.toNamed(AppRoutes.faqscreen)
                                        : _con.drawerIndex.value == 4
                                            ? Platform.isIOS
                                                ? showDialog(
                                                    barrierColor:
                                                        const Color.fromRGBO(
                                                            0, 0, 0, 0.76),
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CupertinoAlertDialog(
                                                        title: Text(
                                                          AppString.logout,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        content: Text(
                                                          AppString.surelogout,
                                                        ),
                                                        actions: <Widget>[
                                                          CupertinoDialogAction(
                                                            isDefaultAction:
                                                                true,
                                                            child: Text(
                                                              AppString.cancel,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            onPressed: () =>
                                                                Get.back(),
                                                          ),
                                                          CupertinoDialogAction(
                                                            child: Text(
                                                              AppString.logout,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Get.offAllNamed(
                                                                AppRoutes
                                                                    .loginScreen,
                                                              );
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    })
                                                : logoutDialog(
                                                    context: Get.context,
                                                    onTap: () {
                                                      Get.offAllNamed(AppRoutes
                                                          .loginScreen);
                                                      GetStorage()
                                                          .remove("isIt");
                                                    },
                                                  )
                                            : null;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        width: Get.width,
                        child: Row(
                          children: [
                            Image.asset(
                              _con.drawerList[index].image,
                              height: 20,
                              width: 20,
                            ),
                            wSizedBox16,
                            Text(
                              _con.drawerList[index].title,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                x != null
                    ? Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://sin5.org/images/faces/1.jpg"),
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                          ),
                          wSizedBox20,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                hSizedBox4,
                                Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const Text("login"),
                hSizedBox30,
              ],
            ),
          ),
          Positioned(
            left: Get.width * 0.69,
            top: Get.height * 0.04,
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.appColor,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  ImageConstant.cross,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
