import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/utills/storage.dart';

AppBar appBar({
  Function()? actionPressed,
  Function()? leadingPressed,
  String? text,
  bool? back,
  Color? backgroundColor,
  String? action,
  bool? actionIcon,
  bool? search,
}) =>
    AppBar(
      backgroundColor: backgroundColor ?? AppColors.secondaryColor,
      elevation: 0,
      leading: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              constraints: const BoxConstraints(),
              icon: Image.asset(
                back == true ? ImageConstant.back : ImageConstant.menu,
                color: backgroundColor == AppColors.appColor
                    ? Colors.white
                    : Colors.black,
                height: back == true ? 18 : 30,
              ),
              onPressed: leadingPressed ??
                  () {
                    Get.back();
                  },
            ),
          ),
        ],
      ),
      centerTitle: true,
      title: Text(
        text!,
        textAlign: TextAlign.center,
        style: GoogleFonts.oswald(
          color: Colors.black,
        ),
      ),
      actions: [
        search == true
            ? IconButton(
                icon: Image.asset(
                  ImageConstant.search,
                  height: 20,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.searchScreen);
                },
              )
            : const SizedBox(),
        if (actionIcon!)
          IconButton(
            icon: Image.asset(
              action ?? ImageConstant.notification,
              color: backgroundColor == AppColors.appColor
                  ? Colors.white
                  : Colors.black,
              height: 20,
            ),
            onPressed: actionPressed ??
                () {
                  Storage.isUserLogin
                      ? Get.toNamed(AppRoutes.notificationScreen)
                      : () {};
                },
          ),
        wSizedBox14,
      ],
    );
