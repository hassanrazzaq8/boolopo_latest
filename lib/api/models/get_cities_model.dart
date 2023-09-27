class GetCitiesModel {
  String? status;
  List<Statelist>? statelist;

  GetCitiesModel({this.status, this.statelist});

  GetCitiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['statelist'] != null) {
      statelist = <Statelist>[];
      json['statelist'].forEach((v) {
        statelist!.add(Statelist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (statelist != null) {
      data['statelist'] = statelist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statelist {
  int? cityId;
  int? countryId;
  int? stateId;
  String? cityName;

  Statelist({this.cityId, this.countryId, this.stateId, this.cityName});

  Statelist.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_name'] = cityName;
    return data;
  }
}
