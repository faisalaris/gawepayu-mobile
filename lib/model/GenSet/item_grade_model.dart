import 'dart:convert';

class ItemGradeResponseModel {
  final String token;
  final String error;

  ItemGradeResponseModel({this.token, this.error});

  factory ItemGradeResponseModel.fromJson(Map<String, dynamic> json) {
    return ItemGradeResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

List<ItemGradeRequestModel> itemGradePostFromJson(String str) => List<ItemGradeRequestModel>.from(json.decode(str).map((x) => ItemGradeRequestModel.fromJson(x)));

class ItemGradeRequestModel {
  String code;
  String description;


  ItemGradeRequestModel({
    this.code,
    this.description,
  });

  factory ItemGradeRequestModel.fromJson(Map<String, dynamic> json) => ItemGradeRequestModel(
        code: json["gcode"],
        description: json["longDesc"],
    );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'gcode': code,
      'longDesc': description,
    };

    return map;
  }
}
