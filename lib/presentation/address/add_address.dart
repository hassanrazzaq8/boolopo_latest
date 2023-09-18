import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/presentation/commamn/app_text_field.dart';
import 'package:watch_app/presentation/dashboard/payment/payment_controller.dart';
import 'package:watch_app/utills/custom_dialogue.dart';
import 'package:watch_app/utills/storage.dart';
import '../../core/utils/constant_sizebox.dart';
import '../commamn/app_button.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final PaymentController _con = Get.put(PaymentController());

  String firstname = "";
  String lastname = "";
  String email = "";
  String phonenumber = "";
  String address = "";
  String postcode = "";
  String country = "";

  @override
  void initState() {
    super.initState();
    getCountriesStates(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(Icons.apps_sharp, color: Colors.black,size: 25,),
        //   )
        // ],
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          "Confirmation",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white60,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          color: Colors.white60,
          child: Column(
            children: [
              hSizedBox20,
              const Text("Please Provide Us Right Information"),
              hSizedBox20,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: Text(
                      "First Name",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AppTextField(
                      shadow: true,
                      hintText: "First Name ",
                      errorMessage: _con.cardnoError,
                      radius: 10,
                      border: true,
                      onChange: (val) {
                        firstname = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: Text(
                      "Last name",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AppTextField(
                      shadow: true,
                      hintText: "Last Name ",
                      errorMessage: _con.cardnoError,
                      radius: 10,
                      border: true,
                      onChange: (val) {
                        lastname = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AppTextField(
                      shadow: true,
                      hintText: "email",
                      errorMessage: _con.cardnoError,
                      radius: 10,
                      border: true,
                      onChange: (val) {
                        email = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AppTextField(
                      shadow: true,
                      hintText: "phone number",
                      errorMessage: _con.cardnoError,
                      radius: 10,
                      border: true,
                      onChange: (val) {
                        phonenumber = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AppTextField(
                      shadow: true,
                      hintText: "address ",
                      errorMessage: _con.cardnoError,
                      radius: 10,
                      border: true,
                      onChange: (val) {
                        address = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: Text(
                      "Post Code",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox8,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: AppTextField(
                      shadow: true,
                      hintText: "post code",
                      errorMessage: _con.cardnoError,
                      radius: 10,
                      border: true,
                      onChange: (val) {
                        postcode = val;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: Text(
                      "Country",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox8,
                  Container(
                    height: Get.height * 0.07,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 0,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Get.height * .01))),
                    child: ButtonTheme(
                      child: DropdownButton<dynamic>(
                        menuMaxHeight: Get.height * .55,
                        hint: const Text(
                          "Country",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                        value: selectedCountry,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: Get.height * .035,
                        ),
                        underline: const SizedBox(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCountry = newValue;
                            selectedState = null;
                            getStates(selectedCountry!);
                          });
                        },
                        items: countries
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                )))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                    child: Text(
                      "State",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  hSizedBox8,
                  Container(
                    height: Get.height * 0.07,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 0,
                            offset: const Offset(0, 3),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Get.height * .01))),
                    child: ButtonTheme(
                      child: DropdownButton<dynamic>(
                        menuMaxHeight: Get.height * .55,
                        hint: const Text(
                          "State",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                        value: selectedState,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: Get.height * .035,
                        ),
                        underline: const SizedBox(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedState = newValue;
                          });
                        },
                        items: states
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                )))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
              hSizedBox20,
              AppButton(
                text: " Submit",
                width: Get.width / 2,
                onPressed: () {
                  if (firstname != "" &&
                      lastname != "" &&
                      email != "" &&
                      phonenumber != "" &&
                      address != "" &&
                      postcode != "" &&
                      selectedCountry != null) {
                    _handleAddress();
                  } else {
                    GetStorage().remove(AppString.address);
                    customDialogue(message: "Please fill all fields to proceed");
                  }
                },
              ),
              hSizedBox20,
            ],
          ),
        ),
      ),
    );
  }

  List<dynamic> countriesStates = [];
  List countries = [];
  List states = [];
  String? selectedCountry, selectedState;
  List currentAddresses = [];

  Future<void> getCountriesStates(context) async {
    try {
      Map<String, dynamic> parameters = {
        "consumer_key": "ck_f5374351dfaa2587fbdf22bc691eeb88e87731bc",
        "consumer_secret": "cs_01c326a844bbdf18e1b54a2de7e5a238f8e73eb5",
      };
      countriesStates = await Api.getMethod(context,
          url: getCountriesStatesApi,
          parameters: parameters,
          forCountries: true);
      if (countriesStates.isEmpty) {
        customDialogue(
          message:
              "Something went wrong Please Check the internet connection or restart the application",
        );
      } else {
        for (var i in countriesStates) {
          countries.add(i["name"]);
        }

        debugPrint("countries fetched : $countries");
        debugPrint("states fetched : $states");
      }
      setState(() {});
    } catch (err) {
      debugPrint("error while fetching countries : $err");
    }
  }

  getStates(String countryName) {
    final isExist =
        countriesStates.where((test) => test["name"] == countryName);
    final data = isExist.toList();
    debugPrint("data after selecting country : $data");
    if (data.isNotEmpty) {
      if (data[0]["states"].isNotEmpty) {
        for (var i in data[0]["states"]) {
          states.add(i["name"]);
        }
      } else {
        states = [];
      }
    }

    debugPrint("states are : $states");
  }

  _handleAddress() async {
    Map<String, dynamic> addressData = {
      "firstName": firstname.trim(),
      "lastName": lastname.trim(),
      "email": email.trim(),
      "country": selectedCountry?.trim(),
      "state": selectedState?.trim(),
      "postcode": postcode.trim(),
      "phoneNumber": phonenumber.trim(),
      "address": address.trim(),
    };

    if (GetStorage().read(AppString.address) != null) {
      currentAddresses = GetStorage().read(AppString.address);
    } else {
      currentAddresses = [];
    }
    currentAddresses.add(addressData);
    await GetStorage().write(AppString.address, currentAddresses).then((value) {
      Get.back();
    });
    setState(() {});
  }
}
