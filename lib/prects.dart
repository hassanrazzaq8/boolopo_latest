import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/presentation/bottomBar/bottombar_controller.dart';
import 'package:watch_app/utills/storage.dart';

class Prects extends StatefulWidget {
  const Prects({Key? key}) : super(key: key);

  @override
  State<Prects> createState() => _PrectsState();
}

class _PrectsState extends State<Prects> {
  final BottomBarController _con = Get.put(BottomBarController());

  bool showNext = false, showBrands = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.black,
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showNext = !showNext;
                    });
                  },
                  child: const Text("show second one")),
              // SizedBox(height: Get.height * 0.05),
              Center(
                child: Container(
                  height: Get.height * .15,
                  width: Get.height * .15,
                  decoration: const BoxDecoration(),
                  child: Image.asset(
                    ImageConstant.appLogo,
                  ),
                ),
              ),
              hSizedBox36,
              const Divider(
                color: Colors.white,
                thickness: 1.5,
              ),
              hSizedBox36,
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: index == 1
                          // ? _con.pageIndex.value == 0
                      ?showNext
                              ? Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      width: Get.width,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            _con.drawerList[index].image,
                                            height: 20,
                                            width: 20,
                                            color: Colors.white,
                                          ),
                                          wSizedBox16,
                                          Text(
                                            _con.drawerList[index].title,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showBrands = !showBrands;
                                              });
                                            },
                                            icon: showBrands
                                                ? Transform.flip(
                                                    flipY: true,
                                                    child: const Icon(
                                                      Icons
                                                          .arrow_drop_down_circle_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .arrow_drop_down_circle_outlined,
                                                    color: Colors.white,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showBrands
                                        ? ScrollConfiguration(
                                              behavior: const ScrollBehavior()
                                                  .copyWith(overscroll: false),
                                              child: ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                itemCount:10,
                                                // _con
                                                //         .getAllBrandsModel
                                                //         .brandlist
                                                //         ?.length ??
                                                //     0,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _con.selectedLeftitem
                                                            .value = -1;
                                                        _con.selectedTopItem
                                                            .value = -1;
                                                        _con.brandId
                                                            .value = _con
                                                                .getAllBrandsModel
                                                                .brandlist?[
                                                                    index]
                                                                .termId
                                                                .toString() ??
                                                            "3103";
                                                      });
                                                      Get.back();
                                                      _con.getProducts(
                                                        context,
                                                        selectedOption:
                                                            GetProductsBy
                                                                .brands,
                                                        brandId: _con
                                                            .getAllBrandsModel
                                                            .brandlist?[index]
                                                            .termId
                                                            .toString(),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      width: Get.width,
                                                      child: Text(
                                                        _con
                                                                .getAllBrandsModel
                                                                .brandlist?[
                                                                    index]
                                                                .name ??
                                                            "",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )

                                        : const SizedBox.shrink(),
                                  ],
                                )
                              : const SizedBox.shrink()
                          : Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        width: Get.width,
                        child: Row(
                          children: [
                            Image.asset(
                              _con.drawerList[index].image,
                              height: 20,
                              width: 20,
                            ),
                            wSizedBox16,
                            Text(
                              _con.drawerList[index].title,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                    return index == 2 && showNext
                        ? Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    width: 100,
                                    color: Colors.green,
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                  );
                                },
                              )
                            ],
                          )
                        : Container(
                            height: 50,
                            width: 50,
                            color: Colors.red,
                            margin: EdgeInsets.symmetric(vertical: 20),
                          );
                  },
                ),
              ),
              const Text("data"),
              Storage.isUserLogin
                  ? Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://sin5.org/images/faces/1.jpg"),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                  ),
                  wSizedBox20,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "username",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        hSizedBox4,
                        Text(
                          "email",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : const Text("login"),
              hSizedBox30,
            ],
          ),
        ),
      ),
    );
  }
}
