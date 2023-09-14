import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_bar.dart';
import 'package:watch_app/presentation/commamn/clip_path.dart';
import 'package:watch_app/presentation/dashboard/editProfile/edit_profile_controller.dart';
import 'package:watch_app/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import '../../../core/app_export.dart';
import '../../commamn/app_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController _con = Get.put(EditProfileController());
  TextEditingController userid = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  int id = GetStorage().read("userId");
  String? fname = GetStorage().read("firstName");
  String? lname = GetStorage().read("lastName");
  String? pimage;
  File? profile_image;
  Future edit() async {
    try {
      const url = "https://boolopo.co/apies/editprofile.php";
      final response = await http.post(Uri.parse(url), body: {
        "userid": firstname.text.toString(),
        "first_name": firstname.text.toString(),
        "last_name": lastname.text.toString(),
        profile_image: _con.profileImage.value.toString(),
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        fname = data["first_name"];
        lname = data["last_name"];
        pimage = data[profile_image];
        print(data);
        print("Profile updated successfuly");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
    GetStorage box = GetStorage();
    box.write("firstName", fname);
    box.write("lastName", lname);
    box.write("userId", id);
    box.write("profileImage", pimage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        actionPressed: () {
          Get.toNamed(AppRoutes.notificationScreen);
        },
        backgroundColor: AppColors.appColor,
        action: ImageConstant.notification,
        text: AppString.profile,
        back: true,
        actionIcon: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                width: Get.width,
                height: 170,
                color: AppColors.appColor,
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Obx(
                          () => Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: _con.profileImage.value.path.isEmpty
                                    ? _con.profileUrl.value != ""
                                        // ? NetworkImage(
                                        //     _con.profileUrl.value,
                                        //   )
                                        ? const NetworkImage(
                                            "https://sin5.org/images/faces/1.jpg")
                                        : const AssetImage(
                                            ImageConstant.cam,
                                          ) as ImageProvider
                                    : FileImage(
                                        _con.profileImage.value,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -15,
                          child: GestureDetector(
                            onTap: () {
                              _con.pickProfileFile(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Image.asset(
                                ImageConstant.cam,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            hSizedBox20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText(AppString.userid),
                  hSizedBox6,
                  CustomTextfiled(
                    controller: userid,
                    shadow: true,
                    hintText: id.toString(),
                    onChange: (value) {
                      id = int.parse(value);
                    },
                  ),
                  hSizedBox4,
                  titleText(AppString.firstName),
                  hSizedBox6,
                  CustomTextfiled(
                    controller: firstname,
                    shadow: true,
                    hintText: fname,
                    onChange: (value) {
                      fname = value;
                    },
                  ),
                  hSizedBox4,
                  titleText(AppString.lastName),
                  hSizedBox6,
                  CustomTextfiled(
                    controller: lastname,
                    shadow: true,
                    hintText: lname,
                    radius: 30,
                    border: true,
                    onChange: (value) {
                      fname = value;
                    },
                  ),
                  hSizedBox4,
                  titleText(AppString.aboutme),
                  hSizedBox6,
                  CustomTextfiled(
                    shadow: true,
                    maxLines: 2,
                    hintText: "write something...",
                    radius: 100,
                    border: true,
                    onChange: (val) {
                      _con.bio.value = val;
                    },
                  ),
                  hSizedBox18,
                  Center(
                    child: AppButton(
                      text: AppString.save,
                      width: Get.width / 2,
                      onPressed: () {
                        edit();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  hSizedBox18,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  titleText(inputTitle) {
    return Text(
      inputTitle,
      style: const TextStyle(
        fontSize: 15,
        color: Color(0xff707070),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
