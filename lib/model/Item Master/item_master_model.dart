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

class ItemMasterPostModel{
  dynamic parent;
  dynamic openingBalanceStocks;
  String prefix;
  dynamic code;
  String barcode;
  String description;
  String group;
  String grade;
  String satuan;
  dynamic inStock;
  dynamic totalInstock;
  dynamic minStock;
  dynamic maxStock;
  dynamic inputDate;
  dynamic curpricelist;
  dynamic qtySat;
  dynamic inStockBalance; 
  String isdeadstock;

    ItemMasterPostModel({
    this.parent,
    this.openingBalanceStocks,
    this.prefix,
    this.code,
    this.barcode,
    this.description,
    this.group,
    this.grade,
    this.satuan,
    this.inStock,
    this.totalInstock,
    this.minStock,
    this.maxStock,
    this.inputDate,
    this.curpricelist,
    this.qtySat,
    this.inStockBalance, 
    this.isdeadstock,
  });

 factory ItemMasterPostModel.fromJson(Map<String, dynamic> json) => ItemMasterPostModel(
        parent: json["parent"] ?? 0,
        openingBalanceStocks : json["openningBalanceStock"],
        prefix: json["prefix"] ?? '',
        code: json["code"],
        barcode: json["barCode"],
        description: json["desc"],
        group: json["group"],
        grade: json["grade"],
        satuan: json["satuan"],
        inStock: json["inStock"],
        totalInstock: json["totalInStock"],
        minStock: json["minStock"],
        maxStock: json["maxStock"],
        inputDate: json["inputDate"],
        curpricelist:json["currentPpriceList"],
        qtySat: json["qtySat"],
        inStockBalance: json["inStockBalance"] ?? 0,
        isdeadstock: json["isDeadStock"] ?? '1',
    );

    Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "parent" : parent,
      "openningBalanceStock" : openingBalanceStocks,
      "prefix" : prefix,
      "barcode": barcode,
      "desc": description,
      "group": group,
      "grade": grade,
      "satuan" : satuan,
      "inStock": inStock,
      "totalInStock": totalInstock,
      "minStock": minStock,
      "maxStock": maxStock,
      "inputDate" : inputDate,
      "currentPpriceList" : curpricelist,
      "qtySat": qtySat,
      "inStockBalance" : inStockBalance,
      "isdeadstock":isdeadstock, 
    };
    return map;
  }

}

class ItemMasterPutModel {
  dynamic parent;
  dynamic openingBalanceStocks;
  String prefix;
  dynamic code;
  String barcode;
  String description;
  String group;
  String grade;
  String satuan;
  dynamic inStock;
  dynamic totalInstock;
  dynamic minStock;
  dynamic maxStock;
  dynamic inputDate;
  dynamic curpricelist;
  dynamic qtySat;
  dynamic inStockBalance; 
  String isdeadstock;
  List <SpriceList> sPriceList;

  ItemMasterPutModel({
    this.parent,
    this.openingBalanceStocks,
    this.prefix,
    this.code,
    this.barcode,
    this.description,
    this.group,
    this.grade,
    this.satuan,
    this.inStock,
    this.totalInstock,
    this.minStock,
    this.maxStock,
    this.inputDate,
    this.curpricelist,
    this.qtySat,
    this.inStockBalance, 
    this.isdeadstock,
    this.sPriceList
  });

factory ItemMasterPutModel.fromJson(Map<String, dynamic> json) => ItemMasterPutModel(
        parent: json["parent"] ?? 0,
        openingBalanceStocks : json["openningBalanceStock"],
        prefix: json["prefix"] ?? '',
        code: json["code"],
        barcode: json["barCode"],
        description: json["desc"],
        group: json["group"],
        grade: json["grade"],
        satuan: json["satuan"],
        inStock: json["inStock"],
        totalInstock: json["totalInStock"],
        minStock: json["minStock"],
        maxStock: json["maxStock"],
        inputDate: json["inputDate"],
        curpricelist:json["currentPpriceList"],
        qtySat: json["qtySat"],
        inStockBalance: json["inStockBalance"] ?? 0,
        isdeadstock: json["isDeadStock"] ?? '1',
        sPriceList: json["invSpriceLists"] == null ? null: List<SpriceList>.from(json["invSpriceLists"].map((x) => SpriceList.fromJson(x))),
    );

    Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "parent" : parent,
      "openningBalanceStock" : openingBalanceStocks,
      "prefix" : prefix,
      "barcode": barcode,
      "desc": description,
      "group": group,
      "grade": grade,
      "satuan" : satuan,
      "inStock": inStock,
      "totalInStock": totalInstock,
      "minStock": minStock,
      "maxStock": maxStock,
      "inputDate" : inputDate,
      "currentPpriceList" : curpricelist,
      "qtySat": qtySat,
      "inStockBalance" : inStockBalance,
      "isdeadstock":isdeadstock,
      "invSpriceLists": sPriceList == null ? null: List<dynamic>.from(sPriceList.map((x) => x.toJson())), 
    };
    return map;
  }


}

class ItemMasterRequestModel {
  dynamic parent;
  dynamic openingBalanceStocks;
  String prefix;
  dynamic code;
  String barcode;
  String description;
  List<Group> group;
  List<Grade> grade;
  String satuan;
  dynamic inStock;
  dynamic totalInstock;
  dynamic minStock;
  dynamic maxStock;
  dynamic inputDate;
  dynamic curpricelist;
  dynamic qtySat;
  dynamic inStockBalance; 
  String isdeadstock;
  List <SpriceList> sPriceList;
  List <PpriceList> pPriceList;
  
 
  
  ItemMasterRequestModel({
    this.parent,
    this.openingBalanceStocks,
    this.prefix,
    this.code,
    this.barcode,
    this.description,
    this.group,
    this.grade,
    this.satuan,
    this.inStock,
    this.totalInstock,
    this.minStock,
    this.maxStock,
    this.inputDate,
    this.curpricelist,
    this.qtySat,
    this.inStockBalance, 
    this.isdeadstock,
    this.sPriceList,
    this.pPriceList
  });

  factory ItemMasterRequestModel.fromJson(Map<String, dynamic> json) => ItemMasterRequestModel(
        parent: json["parent"] ?? 0,
        openingBalanceStocks : json["openningBalanceStock"],
        prefix: json["prefix"] ?? '',
        code: json["code"],
        barcode: json["barCode"],
        description: json["desc"],
        group: json["group"] == null ? null: List<Group>.from(json["group"].map((x) => Group.fromJson(x))),
        grade: json["grade"] == null ? null: List<Grade>.from(json["grade"].map((x) => Grade.fromJson(x))),
        satuan: json["satuan"],
        inStock: json["inStock"],
        totalInstock: json["totalInStock"],
        minStock: json["minStock"],
        maxStock: json["maxStock"],
        inputDate: json["inputDate"],
        curpricelist:json["currentPpriceList"],
        qtySat: json["qtySat"],
        inStockBalance: json["inStockBalance"] ?? 0,
        isdeadstock: json["isDeadStock"] ?? '1',
        sPriceList: json["invSpriceLists"] == null ? null: List<SpriceList>.from(json["invSpriceLists"].map((x) => SpriceList.fromJson(x))),
        pPriceList: json["invPpriceList"] == null ? null: List<PpriceList>.from(json["invPpriceList"].map((x) => PpriceList.fromJson(x)))
    );


  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "parent" : parent,
      "openningBalanceStock" : openingBalanceStocks,
      "prefix" : prefix,
      "barcode": barcode,
      "desc": description,
      "group": group == null ? null: List<dynamic>.from(group.map((x) => x.toJson())),
      "grade": grade == null ? null: List<dynamic>.from(grade.map((x) => x.toJson())),
      "satuan" : satuan,
      "inStock": inStock,
      "totalInStock": totalInstock,
      "minStock": minStock,
      "maxStock": maxStock,
      "inputDate" : inputDate,
      "currentPpriceList" : curpricelist,
      "qtySat": qtySat,
      "inStockBalance" : inStockBalance,
      "isdeadstock":isdeadstock, 
      "invSpriceLists": sPriceList == null ? null: List<dynamic>.from(sPriceList.map((x) => x.toJson())),
      "invPpriceList" : pPriceList == null ? null: List<dynamic>.from(pPriceList.map((x) => x.toJson()))
    };
    return map;
  }
}

class SpriceList {
  dynamic id;
  dynamic code;
  dynamic qty;
  dynamic price;
  dynamic lastUpdate;

SpriceList({
this.id,
this.code,
this.qty,
this.price,
this.lastUpdate
});

SpriceList copy({
    dynamic id,
    dynamic code,
    dynamic qty,
    dynamic price,
    dynamic lastUpdate
  }) =>
      SpriceList(
        id : id ?? this.id,
        code : code ?? this.code,
        qty: qty ?? this.qty,
        price: price ?? this.price,
        lastUpdate : lastUpdate ?? this.lastUpdate,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpriceList &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          code == other.code &&
          qty == other.qty &&
          price == other.price && 
          lastUpdate == other.lastUpdate;

  @override
  int get hashCode => id.hashCode ^ code.hashCode ^ qty.hashCode ^ price.hashCode ^ lastUpdate.hashCode ;



factory SpriceList.fromJson(Map<String, dynamic> json) => SpriceList(
id: json["id"],
code: json["code"],
qty: json["qty"],
price: json["price"],
lastUpdate: json["lastUpdated"]
);

Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id" :id,
      "code": code,
      "qty" : qty,
      "price" : price,
      "lastUpdated" : lastUpdate 
    };
    return map ;
}

}

class Group {
  String gtype;
  String gcode;
  String longDesc;
  String systemParam;
  dynamic pmargin;

Group({
this.gtype,
this.gcode,
this.longDesc,
this.systemParam,
this.pmargin
}); 

factory Group.fromJson(Map<String, dynamic> json) => Group(
gtype: json["gtype"],
gcode: json["gcode"],
longDesc: json["longDesc"],
systemParam: json["systemParam"],
pmargin: json["pmargin"]
);

Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "gtype" :gtype,
      "gcode": gcode,
      "longDesc" : longDesc,
      "systemParam" : systemParam,
      "pmargin" : pmargin 
    };
    return map ;
}

}


class Grade {
  String gtype;
  String gcode;
  String longDesc;
  String systemParam;
  dynamic pmargin;

Grade({
this.gtype,
this.gcode,
this.longDesc,
this.systemParam,
this.pmargin
}); 

factory Grade.fromJson(Map<String, dynamic> json) => Grade(
gtype: json["gtype"],
gcode: json["gcode"],
longDesc: json["longDesc"],
systemParam: json["systemParam"],
pmargin: json["pmargin"]
);

Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "gtype" :gtype,
      "gcode": gcode,
      "longDesc" : longDesc,
      "systemParam" : systemParam,
      "pmargin" : pmargin 
    };
    return map ;

}
}

class PpriceList{
  dynamic id;
  dynamic code;
  List <BusinessP> businessP;
  dynamic price;
  String lastPurchase;

PpriceList({
this.id,
this.code,
this.businessP,
this.price,
this.lastPurchase
});

factory PpriceList.fromJson(Map<String, dynamic> json) => PpriceList(
id: json["id"] ,
code: json["code"],
businessP: json["businessPartner"] == null ? null: List<BusinessP>.from(json["businessPartner"].map((x) => BusinessP.fromJson(x))),
price: json["price"],
lastPurchase: json["lastPurchase"]
);

Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id" :id,
      "code": code,
      "businessPartner" : businessP == null ? null: List<dynamic>.from(businessP.map((x) => x.toJson())),
      "price" : price,
      "lastPurchase" : lastPurchase 
    };
    return map ;
}

}

class BusinessP{
  String code;
  String desc;
  String type;
  String addr;
  String city;
  dynamic zip;
  String phone;
  String fax;
  String dtFrom;
  String dtTo;
  String isDeleted;
  dynamic point;
  String npwp;
  String email;

BusinessP({
this.code,
this.desc,
this.type,
this.addr,
this.city,
this.zip,
this.phone,
this.fax,
this.dtFrom,
this.dtTo,
this.isDeleted,
this.point,
this.npwp,
this.email
});

factory BusinessP.fromJson(Map<String, dynamic> json) => BusinessP(
code: json["code"],
desc: json["desc"],
type: json["type"],
addr: json["addr"],
city: json["city"],
zip: json["zip"],
phone: json["phone"],
fax: json["fax"],
dtFrom: json["dtFrom"],
dtTo: json["dtTo"],
isDeleted: json["isDeleted"],
point: json["point"],
npwp: json["npwp"],
email: json["email"]
);


Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "code" :code,
      "desc": desc,
      "type" : type,
      "addr" : addr,
      "city" : city,
      "zip" : zip,
      "phone" : phone,
      "fax" : fax,
      "dtFrom" : dtFrom,
      "dtTo" : dtTo,
      "isDeleted" : isDeleted,
      "point" : point,
      "npwp" : npwp,
      "email" : email,  
    };
    return map ;

}
}

class IsDeadStock{
String code ;

IsDeadStock({
  this.code
});

}