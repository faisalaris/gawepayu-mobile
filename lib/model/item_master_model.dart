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
  String parent;
  String code;
  String barcode;
  String description;
  String group;
  String grade;
  int isdeadstock;
  int qtySat;
  int inStock;
  int totalInstock;
  int minStock;
  int maxStock;
  int curpricelist;


  ItemMasterRequestModel({
    this.parent,
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
        parent: json["parent"],
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
      'parent': parent.trim(),
      'code': code.trim(),
      'barcode': barcode.trim(),
      'description': description.trim(),
      'group': group.trim(),
      'grade': grade.trim(),
      'isdeadstock':isdeadstock,
      'qtysat': qtySat,
      'instock': totalInstock,
      'totalinstock': qtySat,
      'minstock': minStock,
      'maxstock': maxStock,
      'curpricelist' : curpricelist
    };

    return map;
  }
}

