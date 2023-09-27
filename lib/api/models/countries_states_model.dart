class GetCountriesModel {
  String? status;
  List<Countrylist>? countrylist;

  GetCountriesModel({this.status, this.countrylist});

  GetCountriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['countrylist'] != null) {
      countrylist = <Countrylist>[];
      json['countrylist'].forEach((v) {
        countrylist!.add(Countrylist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (countrylist != null) {
      data['countrylist'] = countrylist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countrylist {
  int? countryId;
  String? countryName;

  Countrylist({this.countryId, this.countryName});

  Countrylist.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    return data;
  }
}
