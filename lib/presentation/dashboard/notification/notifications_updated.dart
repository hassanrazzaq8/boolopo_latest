import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/models/notifications_model.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_bar.dart';
import 'package:watch_app/utills/color.dart';
import 'package:watch_app/utills/custom_dialogue.dart';
import 'package:watch_app/utills/loader.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  NotificationsModel notificationsModel = NotificationsModel();
  bool notificationFetch = false;

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: AppString.notification,
        back: true,
        actionIcon: true,
      ),
      body: notificationFetch
          ? ListView.builder(
              itemCount: notificationsModel.notification?.length ?? 0,
              itemBuilder: (context, index) {
                return notificationTile(
                    notificationsModel.notification?[index].title ??
                        "no title found",
                    body: notificationsModel.notification?[index].description ??
                        "no title found");
              },
            )
          : Loader.apiLoading(
              color: Colors.black,
            ),
    );
  }

  Future<void> getNotifications() async {
    try {
      setState(() {
        notificationFetch = false;
      });
      var data = await Api.getMethod(context, url: getNotificationsApi);
      if (data != null) {
        notificationsModel = NotificationsModel.fromJson(data);
        debugPrint("notification list : ${notificationsModel.notification}");
        if (notificationsModel.notification == null) {
          customDialogue(
            message:
                "Something went wrong Please Check the internet connection or restart the application",
          );
        }
      } else {
        notificationsModel.notification = [];
      }

      setState(() {
        notificationFetch = true;
      });
    } catch (err) {
      debugPrint("error while fetching orders : $err");
      setState(() {
        notificationFetch = true;
      });
    }
  }

  Widget notificationTile(
    String title, {
    required String body,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Get.height * .04),
            border: Border.all(color: Colors.grey)),
        margin: EdgeInsets.all(Get.height * .02),
        padding: EdgeInsets.all(Get.width*.03),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              padding: EdgeInsets.all(Get.height * .01),
              child: Icon(
                Icons.notifications,
                size: Get.height * .05,
                color: Colors.white,
              ),
            ),
            wSizedBox4,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:Get.width * .01),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.openSans(
                        fontSize: Get.textScaleFactor * 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    hSizedBox4,
                    Text(
                      body,
                      style: GoogleFonts.openSans(
                        fontSize: Get.textScaleFactor * 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
