import 'dart:convert';

class PoMasterRequestModel {
String prefix;
dynamic docNum;
List<BusinessPPO> bpCode;
dynamic docDate;
dynamic postedDate;
dynamic posted;
dynamic paymentType;
List<PoTransDetail>poTransDet; 

PoMasterRequestModel({
this.prefix,
this.docNum,
this.bpCode,
this.docDate,
this.postedDate,
this.posted,
this.paymentType,
this.poTransDet
});

factory PoMasterRequestModel.fromJson(Map<String, dynamic> json) => PoMasterRequestModel(
prefix: json["prefix"],
docNum: json["docNum"],
bpCode: json["bpCode"] == null ? null: List<BusinessPPO>.from(json["bpCode"].map((x) => BusinessPPO.fromJson(x))),
docDate: json["docDate"],
postedDate: json["postedDate"],
posted: json["posted"],
paymentType: json["paymentType"],
poTransDet: json["poTrans"] == null ? null: List<PoTransDetail>.from(json["poTrans"].map((x) => PoTransDetail.fromJson(x)))
    );



Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "prefix": prefix,
      "bpCode" : bpCode == null ? null: List<dynamic>.from(bpCode.map((x) => x.toJson())),
      "docDate" : docDate,
      "postedDate" : postedDate,
      "posted" : posted,
      "paymentType" : paymentType,
      "poTransDet" : poTransDet == null ? null: List<dynamic>.from(poTransDet.map((x) => x.toJson())),
    };
    return map ;

}

}

List<PoMasterRequestModel> pOPostFromJson(String str) => List<PoMasterRequestModel>.from(json.decode(str).map((x) => PoMasterRequestModel.fromJson(x)));


class PoMasterPostModel {
String prefix;
dynamic docNum;
String bpCode;
dynamic docDate;
dynamic postedDate;
dynamic posted;
dynamic paymentType;

PoMasterPostModel({
this.prefix,
this.docNum,
this.bpCode,
this.docDate,
this.postedDate,
this.posted,
this.paymentType,

});

factory PoMasterPostModel.fromJson(Map<String, dynamic> json) => PoMasterPostModel(
prefix: json["prefix"],
bpCode: json["bpCode"],
docDate: json["docDate"],
postedDate: json["postedDate"],
posted: json["posted"],
paymentType: json["paymentType"]
);


Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "prefix": prefix,
      "bpCode" : bpCode,
      "docDate" : docDate,
      "postedDate" : postedDate,
      "posted" : posted,
      "paymentType" : paymentType,
    };
    return map ;

}

}

class PoMasterPutModel {
String prefix;
dynamic docNum;
String bpCode;
dynamic docDate;
dynamic postedDate;
dynamic posted;
dynamic paymentType;
List<PoTransDetailPut>poTransDet;

PoMasterPutModel({
this.prefix,
this.docNum,
this.bpCode,
this.docDate,
this.postedDate,
this.posted,
this.paymentType,
this.poTransDet,
});

factory PoMasterPutModel.fromJson(Map<String, dynamic> json) => PoMasterPutModel(
prefix: json["prefix"],
bpCode: json["bpCode"],
docDate: json["docDate"],
postedDate: json["postedDate"],
posted: json["posted"],
paymentType: json["paymentType"] ,
poTransDet: json["poTransDet"] == null ? null: List<PoTransDetailPut>.from(json["poTransDet"].map((x) => PoTransDetailPut.fromJson(x)))
);


Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "prefix": prefix,
      "bpCode" : bpCode,
      "docDate" : docDate,
      "PostedDate" : postedDate,
      "posted" : posted,
      "paymentType" : paymentType,
      "poTransDet" : poTransDet == null ? null: List<dynamic>.from(poTransDet.map((x) => x.toJson())),
    };
    return map ;

}

}


List<BusinessPPO> businessPostFromJson(String str) => List<BusinessPPO>.from(json.decode(str).map((x) => BusinessPPO.fromJson(x)));

class BusinessPPO{
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

BusinessPPO({
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

 @override
  String toString() {
    return desc;
  }




factory BusinessPPO.fromJson(Map<String, dynamic> json) => BusinessPPO(
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

class PoTransDetail {
  dynamic code;
  dynamic docNum;
  List<ItemMasterPO> itemCode;
  dynamic qty;
  String satuan;
  dynamic qtySatuan;
  dynamic price;
  dynamic totalPrice;
  String updateOpeningBalace;
  String disc1;
  String disc2;
  String disc3;
  String disc4;
  String totalDisc;
  String diff;
  dynamic ppn;

  PoTransDetail({
  this.code,
  this.docNum,
  this.itemCode,
  this.qty,
  this.satuan,
  this.qtySatuan,
  this.price,
  this.totalPrice,
  this.updateOpeningBalace,
  this.disc1,
  this.disc2,
  this.disc3,
  this.disc4,
  this.totalDisc,
  this.diff,
  this.ppn 
  });

  factory PoTransDetail.fromJson(Map<String, dynamic> json) => PoTransDetail(
    code: json["code"],
    docNum: json["docNum"],
    itemCode: json["itemCode"] == null ? null: List<ItemMasterPO>.from(json["itemCode"].map((x) => ItemMasterPO.fromJson(x))),
    qty: json["qty"],
    satuan: json["satuan"],
    qtySatuan: json["qtySatuan"],
    price: json["price"],
    totalPrice: json["totalPrice"],
    updateOpeningBalace: json["updateOpeningBalace"],
    disc1: json["disc1"],
    disc2: json["disc2"],
    disc3: json["disc3"],
    disc4: json["disc4"],
    totalDisc: json["totalDisc"],
    diff: json["diff"],
    ppn: json["ppn"]
  );

Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "code" :code,
      "docNum": docNum,
      "itemCode" : itemCode == null ? null: List<dynamic>.from(itemCode.map((x) => x.toJson())),
      "qty" : qty,
      "satuan" : satuan,
      "qtySatuan" : qtySatuan,
      "price" : price,
      "totalPrice" : totalPrice,
      "updateOpeningBalace" : updateOpeningBalace,
      "disc1" : disc1,
      "disc2" : disc2,
      "disc3" : disc3,
      "disc4" : disc4,
      "totalDisc" : totalDisc,
      "diff" : diff,
      "ppn" : ppn,  
    };
    return map ;

}
  
}

class PoTransDetailPut {
  dynamic code;
  dynamic docNum;
  String itemCode;
  dynamic qty;
  String satuan;
  dynamic qtySatuan;
  dynamic price;
  dynamic totalPrice;
  String updateOpeningBalace;
  String disc1;
  String disc2;
  String disc3;
  String disc4;
  String totalDisc;
  String diff;
  dynamic ppn;

  PoTransDetailPut({
  this.code,
  this.docNum,
  this.itemCode,
  this.qty,
  this.satuan,
  this.qtySatuan,
  this.price,
  this.totalPrice,
  this.updateOpeningBalace,
  this.disc1,
  this.disc2,
  this.disc3,
  this.disc4,
  this.totalDisc,
  this.diff,
  this.ppn 
  });

  PoTransDetailPut copy({
    dynamic code,
    dynamic docNum,
    dynamic itemCode,
    dynamic qty,
    dynamic price,
    dynamic disc1,
    dynamic ppn
  }) =>
      PoTransDetailPut(
        code : code ?? this.code,
        docNum : docNum ?? this.docNum,
        itemCode : itemCode ?? this.itemCode,
        qty: qty ?? this.qty,
        price: price ?? this.price,
        disc1 : disc1 ?? this.disc1,
        ppn : ppn ?? this.ppn,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoTransDetailPut &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          docNum == other.docNum &&
          itemCode == other.itemCode &&
          qty == other.qty &&
          price == other.price && 
          disc1 == other.disc1 &&
          ppn == other.ppn
          ;

  @override
  int get hashCode => itemCode.hashCode ^ docNum.hashCode ^ code.hashCode ^ qty.hashCode ^ price.hashCode ^ disc1.hashCode ^ ppn.hashCode ;

  factory PoTransDetailPut.fromJson(Map<String, dynamic> json) => PoTransDetailPut(
    code: json["code"],
    docNum: json["docNum"],
    itemCode: json["itemCode"],
    qty: json["qty"],
    satuan: json["satuan"],
    qtySatuan: json["qtySatuan"],
    price: json["price"],
    totalPrice: json["totalPrice"],
    updateOpeningBalace: json["updateOpeningBalace"],
    disc1: json["disc1"],
    disc2: json["disc2"],
    disc3: json["disc3"],
    disc4: json["disc4"],
    totalDisc: json["totalDisc"],
    diff: json["diff"],
    ppn: json["ppn"]
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "code" :code,
      "docNum": docNum,
      "itemCode" : itemCode,
      "qty" : qty,
      "satuan" : satuan,
      "qtySatuan" : qtySatuan,
      "price" : price,
      "totalPrice" : totalPrice,
      "updateOpeningBalace" : updateOpeningBalace,
      "disc1" : disc1,
      "disc2" : disc2,
      "disc3" : disc3,
      "disc4" : disc4,
      "totalDisc" : totalDisc,
      "diff" : diff,
      "ppn" : ppn,  
    };
    return map ;

}
}

class ItemMasterPO {
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

  ItemMasterPO ({
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

 factory ItemMasterPO.fromJson(Map<String, dynamic> json) => ItemMasterPO(
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