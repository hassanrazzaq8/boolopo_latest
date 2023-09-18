import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/models/get_all_brands_model.dart';
import 'package:watch_app/api/models/get_products_by_brand_model.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/utils/app_string.dart';
import 'package:watch_app/utills/custom_dialogue.dart';

import '../../core/app_export.dart';

enum GetProductsBy { brands, newRelease, bestSelleer, recommended, leftItems }

class BottomBarController extends GetxController {
  GetAllBrandsModel getAllBrandsModel = GetAllBrandsModel();
  GetProductsByBrandModel getProductsByBrandModel = GetProductsByBrandModel();
  RxInt drawerIndex = 0.obs;
  RxInt pageIndex = Get.arguments != null && Get.arguments is int
      ? RxInt(Get.arguments)
      : 0.obs;
  RxList<Products> products = <Products>[].obs;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt selectedLeftitem = RxInt(0);
  RxInt selectedTopItem = RxInt(-1);

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  RxInt isTap = 0.obs;
  RxBool productsFetch = false.obs;
  RxInt pageNumber = 1.obs;
  RxBool isLoading = false.obs;
  RxString brandId = "3103".obs;
  RxString categoryId = "200".obs;

  List icons = [
    ImageConstant.home,
    ImageConstant.cart,
    ImageConstant.favorite,
    ImageConstant.profile,
  ];

  onTap(index) {
    pageIndex.value = index;
  }

  getProducts(
    BuildContext context, {
    required GetProductsBy selectedOption,
    String? brandId,
    String? categoryId,
  }) {
    pageNumber.value = 1;
    productsFetch.value = false;
    products.value = [];
    isLoading.value = false;
    switch (selectedOption) {
      case GetProductsBy.brands:
        getProductsByBrands(context, brandId: brandId ?? "");
        break;
      case GetProductsBy.newRelease:
        getTopItemProducts(context, url: getnewReleaseProductsApi);
        break;
      case GetProductsBy.bestSelleer:
        getTopItemProducts(context, url: getBestSellerProductsApi);
        break;
      case GetProductsBy.recommended:
        getTopItemProducts(context, url: getRecommendedProductsApi);
        break;
      case GetProductsBy.leftItems:
        getLeftItemProducts(context, categoryId: categoryId ?? "");
        break;
      default:
// Handle the default case if needed
    }
  }

// RxList<DrawerTab> drawerList = RxList([
//   DrawerTab(
//     image: ImageConstant.mappin,
//     title: AppString.deliveryAddress,
//   ),
//   DrawerTab(
//     image: ImageConstant.adduser,
//     title: AppString.invite,
//   ),
//   DrawerTab(
//     image: ImageConstant.creditcard,
//     title: AppString.paymentMethods,
//   ),
//   DrawerTab(
//     image: ImageConstant.help,
//     title: AppString.helpfaq,
//   ),
//   DrawerTab(
//     image: ImageConstant.logout,
//     title: AppString.logOut,
//   ),
// ]);
  RxList<DrawerTab> drawerList = RxList([
    DrawerTab(
      image: ImageConstant.mappin,
      title: AppString.deliveryAddress,
    ),
    DrawerTab(
      image: ImageConstant.office,
      title: "By Brand",
    ),
    DrawerTab(
      image: ImageConstant.help,
      title: AppString.helpfaq,
    ),
    DrawerTab(
      image: ImageConstant.logout,
      title: AppString.logOut,
    ),
  ]);

  Future<void> getBrands(context) async {
    try {
      var data = await Api.getMethod(context, url: getAllBrandsApi);
      getAllBrandsModel = GetAllBrandsModel.fromJson(data);
      if (getAllBrandsModel.brandlist == null) {
        customDialogue(
          message:
              "Something went wrong Please Check the internet connection or restart the application",
        );
      } else {
        getProducts(
          context,
          selectedOption: GetProductsBy.leftItems,
          categoryId: "200",
        );
      }
    } catch (err) {
      debugPrint("error while fetching brands : $err");
    }
  }

  Future<void> getProductsByBrands(context, {required String brandId}) async {
    try {
      Map<String, dynamic> parameters = {
        "term_id": brandId,
        "pageid": pageNumber.value.toString(),
      };
      var data = await Api.getMethod(
        context,
        url: getProductsByBrandsApi,
        parameters: parameters,
      );
      getProductsByBrandModel = GetProductsByBrandModel.fromJson(data);
      if (getProductsByBrandModel.products != null) {
        menagePaginationData(getProductsByBrandModel.products);
      }
      productsFetch.value = true;
      isLoading.value = false;
    } catch (err) {
      productsFetch.value = true;
      debugPrint("error while fetching products by brands : $err");
    }
  }

  Future<void> getTopItemProducts(context, {required String url}) async {
    try {
      Map<String, dynamic> parameters = {
        "pageid": pageNumber.value.toString(),
      };
      debugPrint("params : $parameters");
      var data = await Api.getMethod(
        context,
        url: url,
        parameters: parameters,
      );
      getProductsByBrandModel = GetProductsByBrandModel.fromJson(data);
      if (getProductsByBrandModel.products != null) {
        menagePaginationData(getProductsByBrandModel.products);
      }
      productsFetch.value = true;
      isLoading.value = false;
    } catch (err) {
      productsFetch.value = true;
      debugPrint("error while fetching products by new Release : $err");
    }
  }

  Future<void> getLeftItemProducts(context,
      {required String categoryId}) async {
    try {
      Map<String, dynamic> parameters = {
        "category_id": categoryId,
        "pageid": pageNumber.value.toString(),
      };
      debugPrint("params : $parameters");
      var data = await Api.getMethod(
        context,
        url: getProductsByIdApi,
        parameters: parameters,
      );
      getProductsByBrandModel = GetProductsByBrandModel.fromJson(data);
      if (getProductsByBrandModel.products != null) {
        menagePaginationData(getProductsByBrandModel.products);
      }
      productsFetch.value = true;
      isLoading.value = false;
    } catch (err) {
      productsFetch.value = true;
      debugPrint("error while fetching products by brands : $err");
    }
  }

  trueAndIncrement() {
    ++pageNumber.value;
    isLoading.value = true;
  }

  menagePaginationData(List<Products>? list) {
    if (pageNumber.value == 1 || products.isEmpty) {
      debugPrint("in start list is empty");
      products.value = List.from(list ?? []);
    } else {
      debugPrint("list is not empty");
      products.addAll(list ?? []);
    }
  }
}

class DrawerTab {
  String title;
  String image;

  DrawerTab({
    required this.title,
    required this.image,
  });
}
