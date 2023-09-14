import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/bottomBar/bottombar_screen.dart';
import 'package:watch_app/presentation/commamn/app_button.dart';
import 'package:watch_app/presentation/commamn/app_text_field.dart';
import 'package:watch_app/utills/color.dart';
import 'package:watch_app/utills/snack_bar.dart';
import 'package:watch_app/widgets/custom_textfield.dart';
import '../../../core/app_export.dart';
import '../../dashboard/home/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController pass = TextEditingController();
  TextEditingController user = TextEditingController();
  bool isLoading = false;
  final formkey = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  String? username;
  int? userid;
  String? useremail;
  void login(context) async {
    setState(() {
      isLoading = true;
    });
    try {
      http.Response response = await http.post(
        Uri.parse("https://boolopo.co/apies/login.php"),
        body: {
          "username": user.text.toString(),
          "user_password": pass.text.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(
          response.body.toString(),
        );

        setState(() {
          isLoading = false;
        });
        username = data["user_name"];
        useremail = data["user_email"];
        userid = data["user_id"];
        print(username);
        print(useremail);
        print(userid);

        if (data["status"] == "success") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarScreen(),
            ),
          );
        }
      } else {
        print("failed");
      }
    } catch (e) {
      print(e);
    }
    GetStorage box = GetStorage();
    box.write("username", username);
    box.write("userId", userid);
    box.write("userEmail", useremail);
  }

  @override
  void dispose() {
    super.dispose();
    pass.dispose();
    user.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImageConstant.authbg,
                ),
                fit: BoxFit.cover),
          ),
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
                          Text(
                            AppString.login,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          hSizedBox10,
                          Text(
                            AppString.loginDetails,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          hSizedBox30,
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: formkey,
                            child: CustomTextfiled(
                              controller: user,
                              hintText: AppString.userName,
                              prefixIcon: ImageConstant.email,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "enter username";
                                }
                              },
                            ),
                          ),
                          hSizedBox4,
                          Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: formkey2,
                            child: CustomTextfiled(
                              controller: pass,
                              obsecureText: true,
                              // suffixIcon: GestureDetector(
                              //   onTap: () {
                              //     _con.obsure.toggle();
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(14),
                              //     child: Image.asset(
                              //       ImageConstant.secure,
                              //       height: 20,
                              //       width: 20,
                              //       color: _con.obsure.value == true
                              //           ? Colors.red
                              //           : Colors.green,
                              //     ),
                              //   ),
                              // ),
                              hintText: AppString.password,
                              prefixIcon: ImageConstant.password,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "enter password";
                                } else if (value.length < 6) {
                                  return "Please enter max 6 chracters";
                                }
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(50, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              onPressed: () {
                                Get.toNamed(AppRoutes.forgotPasswordScreen);
                              },
                              child: Text(
                                AppString.forgotPassword,
                                style: const TextStyle(
                                  color: Color(0xff1EB8AC),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.07),
                          AppButton(
                            text: isLoading ? "LOading.." : AppString.login,
                            width: Get.width / 2,
                            onPressed: () {
                              // login(context);
                              final isValid = formkey.currentState!.validate();
                              final isvalid = formkey2.currentState!.validate();
                              if (isValid && isvalid) {
                                login(context);
                                GetStorage().write("isIt", true);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: AppButton(
                              text: "Skip >",
                              width: Get.width / 2,
                              color: themeColor,
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes.bottomBarScreen,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppString.dontHaveanAccount,
                            style: const TextStyle(
                                color: Color(0xff8E8E8E),
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(AppRoutes.signupScreen);
                            },
                            child: Text(
                              AppString.register,
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
