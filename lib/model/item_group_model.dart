import 'dart:convert';

class ItemGroupResponseModel {
  final String token;
  final String error;

  ItemGroupResponseModel({this.token, this.error});

  factory ItemGroupResponseModel.fromJson(Map<String, dynamic> json) {
    return ItemGroupResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

List<ItemGroupRequestModel> itemGroupPostFromJson(String str) => List<ItemGroupRequestModel>.from(json.decode(str).map((x) => ItemGroupRequestModel.fromJson(x)));

class ItemGroupRequestModel {
  String code;
  String description;


  ItemGroupRequestModel({
    this.code,
    this.description,
  });

  factory ItemGroupRequestModel.fromJson(Map<String, dynamic> json) => ItemGroupRequestModel(
        code: json["code"],
        description: json["description"],
    );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'code': code.trim(),
      'description': description.trim(),
    };

    return map;
  }
}
