import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/core/utils/app_string.dart';

class Storage{

  static GetStorage? storage;

  static GetStorage? init()  {
    storage =  GetStorage();
    return storage;
  }

  static String? readData(String key, [String? defValue]) {
    if (storage != null) {
      return storage?.read(key) ?? defValue ?? "";
    }else{
      return null;
    }

  }

  static  writeData(String key, String value) async {
    var instance =  GetStorage();
    return await instance.write(key, value);
  }

  static bool get isUserLogin{
    return storage?.read(AppString.userId)!=null;
  }
  static Future<void>? deleteStorage()async{
    return await storage?.erase();
  }
}