import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/utills/custom_dialogue.dart';

class Api {
  static Future<dynamic> getMethod(
    context, {
    required String url,
    Map<String, dynamic>? parameters,
        bool? forCountries,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse(url).replace(queryParameters: parameters),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(
          response.body.toString(),
        );

       if(forCountries==null){
         if (data["status"] == "success"||data["status"]=="publish") {
           return data;
         } else {
           customDialogue( message: data["status"]);
           return null;
         }
       }else{
           return data;
       }
      } else {
        customDialogue( message: AppString.badHappenedError);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
