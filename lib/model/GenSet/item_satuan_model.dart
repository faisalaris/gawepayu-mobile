import 'dart:convert';

class ItemSatuanRequestModel {
  String code;
  String description;


  ItemSatuanRequestModel({
    this.code,
    this.description,
  });

  factory ItemSatuanRequestModel.fromJson(Map<String, dynamic> json) => ItemSatuanRequestModel(
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

List<ItemSatuanRequestModel> itemSatuanPostFromJson(String str) => List<ItemSatuanRequestModel>.from(json.decode(str).map((x) => ItemSatuanRequestModel.fromJson(x)));
