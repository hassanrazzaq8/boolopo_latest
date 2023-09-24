import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_bar.dart';
import 'package:watch_app/presentation/commamn/app_button.dart';
import 'package:watch_app/presentation/webView/app_web_view.dart';

import 'contact_us_controlller.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);
  final ContactUsController _con = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: AppString.contactus,
        actionIcon: true,
        back: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 217,
                width: Get.width,
                child: Image.asset(
                  ImageConstant.contactusbg,
                ),
              ),
              hSizedBox20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(
                          () => AppWebView(
                              url: "https://boolopo.co/submit-ticket/",
                              title: "Open a Ticket"),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              spreadRadius: .5,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageConstant.customerSupportIcon,
                              color: Colors.black,
                              height: Get.height * .035,
                            ),
                            wSizedBox10,
                            Text(
                              "Open a Ticket",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.textScaleFactor * 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )),
                  wSizedBox14,
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse("https://wa.me/+15015047548"),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: .5,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstant.whatsappIcon,
                            color: Colors.black,
                            height: Get.height * .035,
                          ),
                          wSizedBox10,
                          Text(
                            "Whatsapp",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Get.textScaleFactor * 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              hSizedBox24,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: .5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (val) {
                        _con.name.value = val;
                      },
                      decoration: InputDecoration(
                        hintText: AppString.name,
                        hintStyle: const TextStyle(
                          color: Color(0xffC6C6C6),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffC6C6C6),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffC6C6C6),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => (_con.nameError.value.isNotEmpty)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  _con.nameError.value,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : hSizedBox8,
                    ),
                    hSizedBox14,
                    TextFormField(
                      onChanged: (val) {
                        _con.email.value = val;
                      },
                      decoration: InputDecoration(
                        hintText: AppString.email,
                        hintStyle: const TextStyle(
                          color: Color(0xffC6C6C6),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffC6C6C6),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffC6C6C6),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => (_con.emailError.value.isNotEmpty)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  _con.emailError.value,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : hSizedBox8,
                    ),
                    hSizedBox14,
                    TextFormField(
                      maxLines: 4,
                      onChanged: (val) {
                        _con.mes.value = val;
                      },
                      decoration: InputDecoration(
                          hintText: AppString.mes,
                          hintStyle: const TextStyle(
                            color: Color(0xffC6C6C6),
                          ),
                          border: InputBorder.none),
                    ),
                    Obx(
                      () => (_con.mesError.value.isNotEmpty)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  _con.mesError.value,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : hSizedBox8,
                    ),
                  ],
                ),
              ),
              hSizedBox20,
              AppButton(
                height: 50,
                width: Get.width / 2,
                text: AppString.send,
                onPressed: () {
                  _con.onSend();
                },
              ),
              hSizedBox20,
            ],
          ),
        ),
      ),
    );
  }
}
