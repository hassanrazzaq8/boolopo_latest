class NotificationsModel {
  String? status;
  List<Notification>? notification;

  NotificationsModel({this.status, this.notification});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  int? num;
  String? title;
  String? description;

  Notification({this.num, this.title, this.description});

  Notification.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
