import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/models/countries_states_model.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/utills/custom_dialogue.dart';

class AddressController extends GetxController {
  CountriesStatesModel countriesStatesModel = CountriesStatesModel();
  List<dynamic> countriesStates = [];
  List countries = [];
  RxList<RxString> states = <RxString>[].obs;

  Future<void> getCountriesStates(context) async {
    try {
      Map<String, dynamic> parameters = {
        "consumer_key": "ck_f5374351dfaa2587fbdf22bc691eeb88e87731bc",
        "consumer_secret": "cs_01c326a844bbdf18e1b54a2de7e5a238f8e73eb5",
      };
      var data = await Api.getMethod(context,
          url: getCountriesStatesApi,
          parameters: parameters,
          forCountries: true);
      if (data == null) {
        customDialogue(
          message:
              "Something went wrong Please Check the internet connection or restart the application",
        );
      } else {
        for (var i in data) {
          countries.add( i["name"]);
        }

        debugPrint("countries fetched : $countries");
        debugPrint("states fetched : $states");
      }
    } catch (err) {
      debugPrint("error while fetching countries : $err");
    }
  }
}
