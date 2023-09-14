import 'package:watch_app/core/app_export.dart';

class MyOrderController extends GetxController {
  RxList<MyOrder> myorderList = RxList([
    MyOrder(
      price: 250,
      quantity: 1.obs,
      wimage: ImageConstant.bag,
      wname: "Amazfit  Smart bag ",
    ),
    MyOrder(
      price: 350,
      quantity: 1.obs,
      wimage: ImageConstant.bag,
      wname: "Automatic Lifestyle Chronograph bag ",
    ),
    MyOrder(
      price: 299,
      quantity: 1.obs,
      wimage: ImageConstant.shoe,
      wname: "Nike Big Brand Shoe",
    ),
    MyOrder(
      price: 455,
      quantity: 1.obs,
      wimage: ImageConstant.shoe,
      wname: "Nike Big Brand Shoe",
    )
  ]);

  double subTotal() {
    RxDouble? total = 0.0.obs;
    for (int i = 0; i < myorderList.length; i++) {
      total.value += myorderList[i].price * myorderList[i].quantity.value;
    }
    return total.value;
  }
}

class MyOrder {
  String wimage;
  String wname;
  int price;
  RxInt quantity;

  MyOrder({
    required this.price,
    required this.quantity,
    required this.wimage,
    required this.wname,
  });
}
