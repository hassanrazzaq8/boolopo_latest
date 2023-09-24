import 'package:flutter/material.dart';
import 'package:watch_app/api/api.dart';
import 'package:watch_app/api/models/get_products_by_brand_model.dart';
import 'package:watch_app/api/url.dart';
import 'package:watch_app/core/app_export.dart';
import 'package:watch_app/core/utils/app_string.dart';

class SearchScreenController extends GetxController{

  GetProductsByBrandModel getProductsByBrandModel=GetProductsByBrandModel();
  RxList<Products> searchedProducts=<Products> [].obs;

  RxBool productSearched=true.obs;

  Future<void> searchProduct(String keyWord)async{
    try{
      productSearched.value=false;
      Map<String, dynamic> body = {
        "keyword": keyWord,
      };
      var data = await Api.postMethod(
        url: searchProductsApi,
        body: body,
        showErrorDialogue: false,
      );
      if(data!=null){
        getProductsByBrandModel = GetProductsByBrandModel.fromJson(data);
        if (getProductsByBrandModel.products != null) {
          searchedProducts.value = List.from(getProductsByBrandModel.products ?? []);
        }
        debugPrint("products length : ${searchedProducts.length}");
      }else{
        searchedProducts.value=[];
      }

      productSearched.value=true;

    }catch(err){
      productSearched.value=true;
      debugPrint("error during searching : $err");
    }
  }


}
