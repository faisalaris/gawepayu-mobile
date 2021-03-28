import 'dart:convert';

class ItemMasterResponseModel {
  final String token;
  final String error;

  ItemMasterResponseModel({this.token, this.error});

  factory ItemMasterResponseModel.fromJson(Map<String, dynamic> json) {
    return ItemMasterResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

List<ItemMasterRequestModel> itemMasterPostFromJson(String str) => List<ItemMasterRequestModel>.from(json.decode(str).map((x) => ItemMasterRequestModel.fromJson(x)));



class ItemMasterRequestModel {
  String code;
  String barcode;
  String description;
  String group;
  String grade;
  dynamic isdeadstock;
  dynamic qtySat;
  dynamic inStock;
  dynamic totalInstock;
  dynamic minStock;
  dynamic maxStock;
  dynamic curpricelist;


  ItemMasterRequestModel({
    this.code,
    this.barcode,
    this.description,
    this.group,
    this.grade,
    this.isdeadstock,
    this.qtySat,
    this.inStock,
    this.totalInstock,
    this.minStock,
    this.maxStock,
    this.curpricelist
  });

  factory ItemMasterRequestModel.fromJson(Map<String, dynamic> json) => ItemMasterRequestModel(
        code: json["code"],
        barcode: json["barcode"],
        description: json["description"],
        group: json["group"],
        grade: json["grade"],
        isdeadstock: json["isdeadstock"],
        qtySat: json["qtysat"] ,
        inStock: json["instock"],
        totalInstock: json["totalinstock"],
        minStock: json["minstock"],
        maxStock: json["maxstock"],
        curpricelist:json["curpricelist"]
    );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "code": code,
      "barcode": barcode,
      "description": description,
      "group": group,
      "grade": grade,
      "isdeadstock":isdeadstock,
      "qtysat": qtySat,
      "instock": totalInstock,
      "totalinstock": qtySat,
      "minstock": minStock,
      "maxstock": maxStock,
      "curpricelist" : curpricelist
    };

    return map;
  }
}

