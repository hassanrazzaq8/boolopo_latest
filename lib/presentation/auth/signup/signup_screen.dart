import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_button.dart';
import 'package:http/http.dart' as http;
import 'package:watch_app/widgets/custom_textfield.dart';
import '../../../core/app_export.dart';
import '../../bottomBar/bottombar_screen.dart';
import 'signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _con = Get.put(SignUpController());
  TextEditingController fn = TextEditingController();
  TextEditingController ln = TextEditingController();
  TextEditingController un = TextEditingController();
  TextEditingController pas = TextEditingController();
  TextEditingController em = TextEditingController();
  final form = GlobalKey<FormState>();
  final form2 = GlobalKey<FormState>();
  final form3 = GlobalKey<FormState>();
  final form4 = GlobalKey<FormState>();
  final form5 = GlobalKey<FormState>();
  String? username;
  int? userid;
  String? useremail;
  bool loading = false;
  void register(context) async {
    try {
      setState(() {
        loading = true;
      });
      http.Response response = await http.post(
        Uri.parse("https://boolopo.co/apies/user-accounts.php"),
        body: {
          "first_name": fn.text.toString(),
          "last_name": ln.text.toString(),
          "email": em.text.toString(),
          "username": un.text.toString(),
          "password": pas.text.toString(),
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(
          response.body.toString(),
        );
        setState(() {
          loading = false;
        });
        username = data["user_name"];
        useremail = data["user_email"];
        userid = data["user_id"];
        if (data["status"] == "success") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarScreen(),
            ),
          );
        }
        print("account created successfully");
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e);
    }
  }

  GetStorage box = GetStorage();
  save() {
    GetStorage box = GetStorage();
    box.write("username", username);
    box.write("userId", userid);
    box.write("userEmail", useremail);
    box.write("firstName", fn.text);
    box.write("lastName", ln.text);
  }

  @override
  void dispose() {
    super.dispose();
    fn.dispose();
    ln.dispose();
    un.dispose();
    em.dispose();
    pas.dispose();
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
                      SizedBox(height: Get.height * 0.14),
                      Column(
                        children: [
                          Text(
                            AppString.signup,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          hSizedBox10,
                          Text(
                            AppString.signupDetails,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
                          hSizedBox30,
                          Form(
                            key: form,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: CustomTextfiled(
                              controller: fn,
                              hintText: AppString.firstName,
                              prefixIcon: ImageConstant.userIcon,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Enter first name";
                                }
                              },
                            ),
                          ),
                          hSizedBox4,
                          Form(
                            key: form2,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: CustomTextfiled(
                              controller: ln,
                              hintText: AppString.lastName,
                              prefixIcon: ImageConstant.userIcon,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Enter last name";
                                }
                              },
                            ),
                          ),
                          hSizedBox4,
                          Form(
                            key: form3,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: CustomTextfiled(
                              controller: un,
                              hintText: AppString.userName,
                              prefixIcon: ImageConstant.userIcon,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Enter username";
                                }
                              },
                            ),
                          ),
                          hSizedBox4,
                          Form(
                            key: form4,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: CustomTextfiled(
                              controller: em,
                              hintText: AppString.email,
                              prefixIcon: ImageConstant.email,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Enter  email";
                                }
                              },
                            ),
                          ),
                          hSizedBox4,
                          Obx(
                            () => Form(
                              key: form5,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: CustomTextfiled(
                                controller: pas,
                                obsecureText: _con.obsure.value,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "enter password";
                                  } else if (value.length < 6) {
                                    return "Please enter max 6 chracters";
                                  }
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _con.obsure.toggle();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Image.asset(
                                      ImageConstant.secure,
                                      height: 20,
                                      width: 20,
                                      color: _con.obsure.value == false
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                  ),
                                ),
                                hintText: AppString.password,
                                prefixIcon: ImageConstant.password,
                                onChange: (val) {
                                  _con.password.value = val;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.07),
                          AppButton(
                            text: loading ? "Loading..." : AppString.signup,
                            width: Get.width / 2,
                            onPressed: () {
                              final valid = form.currentState!.validate();
                              final valid2 = form2.currentState!.validate();
                              final valid3 = form3.currentState!.validate();
                              final valid4 = form4.currentState!.validate();
                              final valid5 = form5.currentState!.validate();
                              if (valid &&
                                  valid2 &&
                                  valid3 &&
                                  valid4 &&
                                  valid5) {
                                register(context);
                                save();
                                GetStorage().write("isIt", true);
                              }
                            },
                          ),
                          hSizedBox10,
                          Text(
                            AppString.or,
                            style: const TextStyle(
                              color: Color(0xff8E8E8E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          hSizedBox10,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                socialLoginButton(
                                    image: ImageConstant.google, onTap: () {}),
                                socialLoginButton(
                                    image: ImageConstant.facebook,
                                    onTap: () {}),
                                socialLoginButton(
                                    image: ImageConstant.apple, onTap: () {}),
                              ])
                        ],
                      ),
                      hSizedBox24,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppString.alreadyHaveanAccount,
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
                              )),
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

  socialLoginButton({image, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(6),
        height: 40,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: const Color(0xffD4D4D4)),
        ),
        child: Image.asset(image),
      ),
    );
  }
}
