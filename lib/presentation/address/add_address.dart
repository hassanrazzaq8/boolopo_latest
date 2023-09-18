import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_app/presentation/address/add_address_controller.dart';
import 'package:watch_app/presentation/commamn/app_text_field.dart';
import 'package:watch_app/presentation/dashboard/payment/payment_controller.dart';
import '../../core/utils/constant_sizebox.dart';
import '../commamn/app_button.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

final PaymentController _con = Get.put(PaymentController());
final AddressController _addressController = Get.put(AddressController());

String firstname = "";
String lastname = "";
String email = "";
String phonenumber = "";
String address = "";
String postcode = "";
String country = "";

class _AddAddressState extends State<AddAddress> {
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
                  // Container(
                  //   height: Get.height * 0.07,
                  //   width:  Get.width * 0.42,
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal:  Get.width * 0.05),
                  //   decoration: BoxDecoration(
                  //       boxShadow:  [
                  //         BoxShadow(
                  //           color: Colors.grey.shade200,
                  //           blurRadius: 0,
                  //           offset: const Offset(0, 3),
                  //         )
                  //       ],
                  //       color:Colors.white,
                  //       borderRadius: BorderRadius.all(
                  //           Radius.circular( Get.height * .01))),
                  //   child: ButtonTheme(
                  //     child: DropdownButton<dynamic>(
                  //       menuMaxHeight:  Get.height * .55,
                  //       hint: const Text(
                  //         "State" ?? '',
                  //         style: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 15.0,
                  //         ),
                  //       ),
                  //       value: selectedCountry,
                  //       isExpanded: true,
                  //       icon: Icon(
                  //         Icons.keyboard_arrow_down,
                  //         color: Colors.black,
                  //         size: Get.height * .035,
                  //       ),
                  //       underline: const SizedBox(),
                  //       onChanged: (newValue) {
                  //       },
                  //       items: _addressController.countries
                  //           .map((item) => DropdownMenuItem(
                  //           value: item["name"],
                  //           child: Text(
                  //             item["name"],
                  //             style: const TextStyle(
                  //               color: Colors.black,
                  //               fontSize: 15.0,
                  //             ),
                  //           )))
                  //           .toList(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              hSizedBox20,
              AppButton(
                text: " Submit",
                width: Get.width / 2,
                onPressed: () {
                  _addressController.getCountriesStates(context);
                },
              ),
              hSizedBox20,
            ],
          ),
        ),
      ),
    );
  }

  String? selectedCountry;

  Widget dropDown({
    double? width,
    @required String? selectedCategory,
    @required Function? updateSelectedCategory,
    @required List? categories,
    @required String? hint,
    Color? iconColor,
    bgColor,
  }) {
    return Container(
      height: Get.height * 0.07,
      width: width ?? Get.width,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 0,
              offset: const Offset(0, 3),
            )
          ],
          color: bgColor ?? Colors.white,
          // border: Border.all(color: borderColor ?? AppColors.blackColor),
          borderRadius: BorderRadius.all(Radius.circular(Get.height * .01))),
      child: ButtonTheme(
        child: DropdownButton<String>(
            hint: Text(
              hint ?? '',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            value: selectedCategory,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (newValue) {
              if (updateSelectedCategory != null) {
                updateSelectedCategory(newValue);
              }
            },
            items: categories?.map<DropdownMenuItem<String>>(( value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value == "Imagine" ? "$value  (Coming Soon)" : value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
