import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_bar.dart';
import 'package:watch_app/presentation/commamn/app_button.dart';
import 'package:watch_app/presentation/commamn/app_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:watch_app/utills/loader.dart';
import 'package:watch_app/utills/snack_bar.dart';
import '../../../core/app_export.dart';
import '../../../utills/custom_dialogue.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordController _con = Get.put(ForgotPasswordController());

  forgotPassword() async {
    try {
      Loader.showLoader(context: context);
      const url = "https://boolopo.co/apies/forgotpassword.php";

      final response = await http.post(
        Uri.parse(url),
        body: {
          "useremail": _con.email.value,
        },
      );
      Loader.hideLoader(context);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        if (data["status"] == "success") {
          if (mounted) {
            customDialogue(
                message:
                    "Email has been sent to your email account with password reset link",
                onOkTap: () {
              Get.offAllNamed(AppRoutes.loginScreen);
            });
          }
        } else if (data["status"] == "invalid email") {
          showSnackBar("Invalid Email please check it", context);
        }
      }
    } catch (e) {
      Loader.hideLoader(context);

      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        appBar: appBar(
          back: true,
          text: AppString.forgotPwd,
          backgroundColor: Colors.transparent,
          actionIcon: false,
          actionPressed: () {},
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    ImageConstant.authbg,
                  ),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight: constraints.maxHeight,
                maxHeight: double.infinity,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Spacer(),
                      Column(
                        children: [
                          hSizedBox30,
                          Image.asset(
                            ImageConstant.forgotPasswordbg,
                            height: 240,
                            width: 240,
                          ),
                          hSizedBox20,
                          Text(
                            AppString.forgotPasswordDetails,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          hSizedBox30,
                          AppTextField(
                            hintText: AppString.email,
                            prefixIcon: ImageConstant.email,
                            onChange: (val) {
                              _con.email.value = val;
                            },
                            errorMessage: _con.emailError,
                          ),
                          hSizedBox20,
                          AppButton(
                            text: AppString.send,
                            width: Get.width / 2,
                            onPressed: () {
                              forgotPassword();
                            },
                          )
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppString.backto + " ",
                            style: const TextStyle(
                                color: Color(0xff8E8E8E),
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(AppRoutes.loginScreen);
                            },
                            child: Text(
                              AppString.login,
                              style: TextStyle(
                                  color: AppColors.appColor,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      hSizedBox10,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
