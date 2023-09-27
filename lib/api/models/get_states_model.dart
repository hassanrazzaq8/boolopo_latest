class GetStatesModel {
  String? status;
  List<Statelist>? statelist;

  GetStatesModel({this.status, this.statelist});

  GetStatesModel.fromJson(Map<String, dynamic> json) {
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
  int? stateId;
  String? stateName;

  Statelist({this.stateId, this.stateName});

  Statelist.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state_id'] = stateId;
    data['state_name'] = stateName;
    return data;
  }
}
