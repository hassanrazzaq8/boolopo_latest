class GetOrdersModel {
  String? status;
  List<Orderlist>? orderlist;

  GetOrdersModel({this.status, this.orderlist});

  GetOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orderlist'] != null) {
      orderlist = <Orderlist>[];
      json['orderlist'].forEach((v) {
        orderlist!.add(Orderlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (orderlist != null) {
      data['orderlist'] = orderlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderlist {
  int? orderId;
  String? orderDate;
  String? orderStatus;
  String? orderAmount;

  Orderlist({this.orderId, this.orderDate, this.orderStatus, this.orderAmount});

  Orderlist.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderDate = json['order_date'];
    orderStatus = json['order_status'];
    orderAmount = json['order_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_date'] = orderDate;
    data['order_status'] = orderStatus;
    data['order_amount'] = orderAmount;
    return data;
  }
}
