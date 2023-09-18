import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_bar.dart';
import 'package:watch_app/presentation/commamn/clip_path.dart';
import 'package:watch_app/presentation/dashboard/editProfile/edit_profile_controller.dart';
import 'package:watch_app/utills/custom_dialogue.dart';
import 'package:watch_app/utills/loader.dart';
import 'package:watch_app/utills/storage.dart';
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
  int id = GetStorage().read(AppString.userId);
  String? imageUrl;

  Future edit() async {
    try {
      Loader.showLoader(context: context);
      var request = http.MultipartRequest('POST', Uri.parse(editProfileApi));
      request.fields['userid'] = id.toString();
      request.fields['first_name'] = firstname.text.trim();
      request.fields['last_name'] = lastname.text.trim();
      if ( _con.profileImage.value.path != "") {
        var image = await http.MultipartFile.fromPath(
            'profile_image', _con.profileImage.value.path);
        request.files.add(image);
      }
      final response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);
        Loader.hideLoader(context);
        if (data["status"] == "success") {
          print(data);
          debugPrint("Profile updated successfuly");
          Storage.writeData(AppString.firstName, data["first_name"]);
          Storage.writeData(AppString.lastName, data["last_name"]);
          Storage.writeData(AppString.profileImage, data["profile_image"]);
          customDialogue(message: "Profile details updated successfully");
        } else {
          customDialogue(message: data["status"]);
        }
      }


    } catch (err) {
      Loader.hideLoader(context);
      customDialogue(message: AppString.badHappenedError);
    }
    // GetStorage box = GetStorage();
    // box.write("firstName", fname);
    // box.write("lastName", lname);
    // // box.write("userId", id);
    // box.write("profileImage", pimage);
  }

  @override
  void initState() {
    super.initState();
    firstname =
        TextEditingController(text: Storage.readData(AppString.firstName));
    lastname =
        TextEditingController(text: Storage.readData(AppString.lastName));
    imageUrl = Storage.readData(AppString.profileImage);
    debugPrint("image url is : $imageUrl");
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
                          () => GestureDetector(
                            onTap: () {
                              _con.pickProfileFile(context);
                            },
                            child: Container(
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
                                  fit: BoxFit.cover,
                                  image: _con.profileImage.value.path.isEmpty
                                      ? imageUrl != null?imageUrl!.isNotEmpty
                                          ? NetworkImage(imageUrl!)
                                          :const AssetImage(
                                    ImageConstant.profile,
                                  ) as ImageProvider: const AssetImage(
                                              ImageConstant.profile,
                                            )
                                      : FileImage(
                                          _con.profileImage.value,
                                        ),
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
                  titleText(AppString.firstName),
                  hSizedBox6,
                  CustomTextfiled(
                    controller: firstname,
                    shadow: true,
                    hintText: "Firstname",
                  ),
                  hSizedBox4,
                  titleText(AppString.lastName),
                  hSizedBox6,
                  CustomTextfiled(
                    controller: lastname,
                    shadow: true,
                    hintText: "Lastname",
                    radius: 30,
                    border: true,
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
