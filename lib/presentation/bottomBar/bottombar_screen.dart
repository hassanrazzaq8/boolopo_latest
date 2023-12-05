import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:get_storage/get_storage.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/auth/login/login_screen.dart';
import 'package:watch_app/presentation/commamn/app_button.dart';
import 'package:watch_app/presentation/dashboard/favorite/favorite_screen.dart';
import 'package:watch_app/presentation/dashboard/home/home_page.dart';
import 'package:watch_app/presentation/dashboard/profile/profile_screen.dart';
import 'package:watch_app/presentation/dashboard/shopping_cart/my_cart.dart';
import 'package:watch_app/presentation/webView/app_web_view.dart';
import 'package:watch_app/providers/cart_provider.dart';
import 'package:watch_app/providers/favourite_provider.dart';
import 'package:watch_app/utills/color.dart';
import 'package:watch_app/utills/storage.dart';
import 'package:get/get.dart';
import '../commamn/app_bar.dart';
import '../commamn/app_dialog.dart';
import 'bottombar_controller.dart';

import '../../core/app_export.dart';

class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => BottomBarScreenState();
}

class BottomBarScreenState extends State<BottomBarScreen> {
  final BottomBarController _con = Get.put(BottomBarController());

  bool showBrands = false;
  DateTime backPressTime = DateTime.now();

  Future<bool> exiteApp() {
    print("exite app");
    DateTime now = DateTime.now();
    if (now.difference(backPressTime) < Duration(seconds: 2)) {
      return Future(() => true);
    } else {
      backPressTime = DateTime.now();
      toastMessage();
      return Future(() => false);
    }
  }

  @override
  void initState() {
    super.initState();
    _con.getBrands(context);
  }

  toastMessage() {
    return BotToast.showText(
      text: "Press Again To Exit",
      contentColor: Colors.grey.shade700,
      align: const Alignment(0, .6),
      borderRadius: BorderRadius.circular(Get.height * .2),
      textStyle: TextStyle(
        fontSize: Get.textScaleFactor * 16,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: exiteApp,
        child: Scaffold(
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
                            Storage.isUserLogin
                                ? Get.toNamed(AppRoutes.editProfileScreen)
                                    ?.then((value) {
                                    setState(() {});
                                  })
                                : () {};
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
                          ? Storage.isUserLogin
                              ? ProfileScreen()
                              : Center(
                                  child: AppButton(
                                    text: "Login",
                                    width: Get.width / 3,
                                    onPressed: () {
                                      Get.offAllNamed(AppRoutes.loginScreen);
                                    },
                                  ),
                                )
                          : const HomePage(),
          bottomNavigationBar: bottombar(),
        ),
      ),
    );
  }

  bottombar() {
    final cartProvider = Provider.of<ProviderCart>(context);
    final favouriteProvider = Provider.of<FavoProvider>(context);
    return Container(
      height: Get.height * 0.12,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 0.1),
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
                    icon: Badge(
                      label: index == 2
                          ? Text(
                              favouriteProvider.favouriteItems.toString(),
                            )
                          : Text(
                              cartProvider.cartItems.toString(),
                            ),
                      isLabelVisible: index == 1 || index == 2 ? true : false,
                      backgroundColor: themeColor,
                      child: Image.asset(
                        _con.icons[index],
                        color: _con.pageIndex.value == index
                            ? Colors.white
                            : Colors.black,
                      ),
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
    String username = Storage.readData(AppString.userName) ?? "";
    String email = Storage.readData(AppString.email) ?? "";
    return Drawer(
      backgroundColor: AppColors.appColor,
      child:  Column(
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width*.1),
                  child: const Divider(
                    color: Colors.white,
                    thickness: 1.5,
                  ),
                ),
                hSizedBox6,
                Expanded(
                  child: ListView.builder(

                    shrinkWrap: true,
                    itemCount: _con.drawerList.length+1,
                    padding: EdgeInsets.symmetric(horizontal: Get.width*.05),
                    itemBuilder: (context, index) {
                      return index==_con.drawerList.length?Storage.isUserLogin
                          ? Padding(
                            padding:  EdgeInsets.only(top: Get.height*.03),
                            child: Row(
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
                      ),
                          )
                          : const Text("login") :GestureDetector(
                        onTap: () {
                          _con.drawerIndex.value = index;
                          _con.drawerIndex.value == 0
                              ? Get.toNamed(AppRoutes.orderSummaryScreen)
                              : _con.drawerIndex.value == 2
                                  ? Get.to(
                                      () => AppWebView(
                                          url: "https://boolopo.co/faq-page/",
                                          title: "FAQS"),
                                    )
                                  : _con.drawerIndex.value == 3
                          ? index==3&&!Storage.isUserLogin?Get.offAllNamed(AppRoutes.loginScreen)
                                      :Platform.isIOS
                                          ? showDialog(
                                              barrierColor: const Color.fromRGBO(
                                                  0, 0, 0, 0.76),
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  title: Text(
                                                    AppString.logout,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  content: Text(
                                                    AppString.surelogout,
                                                  ),
                                                  actions: <Widget>[
                                                    CupertinoDialogAction(
                                                      isDefaultAction: true,
                                                      child: Text(
                                                        AppString.cancel,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      onPressed: () => Get.back(),
                                                    ),
                                                    CupertinoDialogAction(
                                                      child: Text(
                                                        AppString.logout,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.offAllNamed(
                                                          AppRoutes.loginScreen,
                                                        );
                                                      },
                                                    )
                                                  ],
                                                );
                                              })
                                          : logoutDialog(
                                              context: Get.context,
                                              onTap: () {
                                                Get.offAllNamed(
                                                    AppRoutes.loginScreen);
                                                Storage.deleteStorage();
                                              },
                                            )
                                      : null;
                        },
                        child: index == 1
                            ? _con.pageIndex.value == 0
                                ? Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        width: Get.width,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              _con.drawerList[index].image,
                                              height: 20,
                                              width: 20,
                                              color: Colors.white,
                                            ),
                                            wSizedBox16,
                                            Text(
                                              _con.drawerList[index].title,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  showBrands = !showBrands;
                                                });
                                              },
                                              icon: showBrands
                                                  ? Transform.flip(
                                                      flipY: true,
                                                      child: const Icon(
                                                        Icons
                                                            .arrow_drop_down_circle_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .arrow_drop_down_circle_outlined,
                                                      color: Colors.white,
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      showBrands
                                          ? ScrollConfiguration(
                                                behavior: const ScrollBehavior()
                                                    .copyWith(overscroll: false),
                                                child: ListView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  itemCount: _con
                                                          .getAllBrandsModel
                                                          .brandlist
                                                          ?.length ??
                                                      0,
                                                  shrinkWrap: true,
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _con.selectedLeftitem
                                                              .value = -1;
                                                          _con.selectedTopItem
                                                              .value = -1;
                                                          _con.brandId
                                                              .value = _con
                                                                  .getAllBrandsModel
                                                                  .brandlist?[
                                                                      index]
                                                                  .termId
                                                                  .toString() ??
                                                              "3103";
                                                        });
                                                        Get.back();
                                                        _con.getProducts(
                                                          context,
                                                          selectedOption:
                                                              GetProductsBy
                                                                  .brands,
                                                          brandId: _con
                                                              .getAllBrandsModel
                                                              .brandlist?[index]
                                                              .termId
                                                              .toString(),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 15),
                                                        width: Get.width,
                                                        child: Text(
                                                          _con
                                                                  .getAllBrandsModel
                                                                  .brandlist?[
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),

                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  )
                                : const SizedBox.shrink()
                            : Container(
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
                                      index==3&&!Storage.isUserLogin?"Login":
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
                ),
                // const Spacer(),

                hSizedBox30,
              ],
            ),

          // Positioned(
          //   left: Get.width * 0.69,
          //   top: Get.height * 0.04,
          //   child: Container(
          //     height: 40,
          //     width: 40,
          //     padding: const EdgeInsets.all(12),
          //     decoration: BoxDecoration(
          //       color: AppColors.appColor,
          //       shape: BoxShape.circle,
          //     ),
          //     child: GestureDetector(
          //       onTap: () {
          //         Get.back();
          //       },
          //       child: Image.asset(
          //         ImageConstant.cross,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),

    );
  }
}
