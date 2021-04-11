import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/Item%20Master/item_master_model.dart';
import '../ItemMasterPage/item_master_viewfromadd_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_http_post_request/api/api_service.dart';
import 'package:flutter_http_post_request/model/GenSet/item_group_model.dart';
import 'package:flutter_http_post_request/model/GenSet/item_grade_model.dart';
import 'package:flutter_http_post_request/model/GenSet/item_satuan_model.dart';
import 'package:flutter_http_post_request/model/Item Master/item_master_model.dart';
import 'package:flutter_http_post_request/pages/ItemMasterPage/Item_master_page.dart';

class ItemAddMaster extends StatefulWidget {
  @override
  _ItemAddMasterState createState() => _ItemAddMasterState();
}

class _ItemAddMasterState extends State<ItemAddMaster> {
  var formKey = GlobalKey<FormState>();
  var barcode = TextEditingController();
  var description = TextEditingController();
  var group = TextEditingController();
  var grade = TextEditingController();
  var isdeadstock = TextEditingController();
  var qtySat = TextEditingController(text: '1');
  var inStock = TextEditingController(text: '0');
  var totalinstock = TextEditingController(text: '0');
  var minsstock = TextEditingController(text: '0');
  var maxstock = TextEditingController(text: '0');
  var curpricelist = TextEditingController(text: '0');
  var satuan = TextEditingController(text: '1');

  String _date = DateTime.now().toIso8601String();

  String _valgroup;
  String _valgrade;
  String _valsatuan;
  String _valdead = "0";
  dynamic _itemCode = 35825;

  List<ItemGroupRequestModel> _listgroup = [];
  List<ItemGradeRequestModel> _listgrade = [];
  List<ItemSatuanRequestModel> _listSatuan = [];
  ItemMasterRequestModel _listmaste = new ItemMasterRequestModel();
  ItemMasterPostModel itemMaster = new ItemMasterPostModel();

  //void getgroup() async {
  //final respose = await http.get(url);
  //List <ItemGroupRequestModel> listData = itemGroupPostFromJson(respose.body);
  //setState(() {
  //_listgroup = listData;
  //});
  //print("data : $listData");
  //}

  //void getgrade() async {
  //final respose = await http.get(urlgrade);
  //List <ItemGradeRequestModel> listData = itemGradePostFromJson(respose.body);
  //setState(() {
  //_listgrade = listData;
  //});
  //print("data : $listData");
  //}

  Future _alertSave(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Info"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemMaster()));
                    },
                    child: Text("Ok"))
              ]);
        });
  }

  Future _alertFailed(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Info"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ]);
        });
  }

  void _onsaved(
      String barcode,
      String description,
      String group,
      String grade,
      String satuan,
      dynamic qtysat,
      dynamic instock,
      dynamic totalInstock,
      dynamic minStock,
      dynamic maxStock,
      dynamic curpricelist,
      dynamic inputdate) {
    setState(() {
      itemMaster.barcode = barcode;
      itemMaster.description = description;
      itemMaster.group = group;
      itemMaster.grade = grade;
      itemMaster.isdeadstock = _valdead;
      itemMaster.qtySat = int.parse(qtysat);
      itemMaster.inStock = int.parse(instock);
      itemMaster.totalInstock = int.parse(totalInstock);
      itemMaster.minStock = int.parse(minStock);
      itemMaster.maxStock = int.parse(maxStock);
      itemMaster.curpricelist = int.parse(curpricelist);
      itemMaster.inputDate = inputdate;
      itemMaster.satuan = satuan;

      APIServiceItemMasterPost apiItemPost = new APIServiceItemMasterPost();
      apiItemPost.tojson(itemMaster);
    });
  }

  @override
  void initState() {
    super.initState();
    APIServiceItemGroup apigroup = new APIServiceItemGroup();
    apigroup.getPost().then((value) {
      setState(() {
        _listgroup.addAll(value);
        _valgroup = _listgroup[0].code;
      });
    });

    APIServiceItemGrade apigrade = new APIServiceItemGrade();
    apigrade.getPost().then((value) {
      setState(() {
        _listgrade.addAll(value);
        _valgrade = _listgrade[0].code;
      });
    });

    APIServiceItemSatuan apisatuan = new APIServiceItemSatuan();
    apisatuan.getPost().then((value) {
      setState(() {
        _listSatuan.addAll(value);
        _valsatuan = _listSatuan[0].code;
      });
    });

    APIServiceItemMasterGet _apiItemGet = new APIServiceItemMasterGet();
    _apiItemGet.getPost(_itemCode).then((value) {
      if (value != null) {
        setState(() {
          _listmaste = value;
        });
      }
    });
    //getgroup();
    //getgrade();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Item Master",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              //Expanded(
              //child:
              //TextFormField(
              //controller : code,
              // decoration : InputDecoration(
              //labelText: 'Code',
              // hintText: 'input Code'
              // ),
              //validator: (value){
              //if (value == null) {
              //return 'Code harus di input';
              //}
              //return null ;
              //},
              //onSaved : (value) => code.text = value
              //)
              //),
              Expanded(
                  child: TextFormField(
                      controller: barcode,
                      decoration: InputDecoration(
                          labelText: 'Barcode', hintText: 'input barcode'),
                      validator: (value) {
                        if (value == null) {
                          return 'Barcode harus di input';
                        }
                        return null;
                      },
                      onSaved: (value) => barcode.text = value)),
              TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                      labelText: 'Deskripsi', hintText: 'input Deskripsi'),
                  validator: (value) {
                    if (value == null) {
                      return 'Deskripsi harus di input';
                    }
                    return null;
                  },
                  onSaved: (value) => description.text = value),
              Expanded(
                  child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropdownButtonFormField(
                        isExpanded: true,
                        decoration: InputDecoration(labelText: 'Group'),
                        hint: Text("pilih Group"),
                        value: _valgroup,
                        items: _listgroup.map(
                          (item) {
                            return DropdownMenuItem(
                                child: Text(item.code + '-' + item.description),
                                value: item.code);
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            _valgroup = value;
                          });
                        },
                      )
                    ]),
              )
              ),
              Expanded(
                  child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropdownButtonFormField(
                        isExpanded: true,
                        hint: Text("pilih Grade"),
                        value: _valgrade,
                        items: _listgrade.map(
                          (item) {
                            return DropdownMenuItem(
                                child: Text(item.code + '-' + item.description),
                                value: item.code);
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            _valgrade = value;
                          });
                        },
                      )
                    ]),
              )),
              Expanded(
                  child: TextFormField(
                controller: qtySat,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Quantity Satuan',
                    hintText: 'input Quantity Satuan'),
              )),
              Expanded(
                  child: TextFormField(
                controller: satuan,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Satuan', hintText: 'inputSatuan'),
              )),
              Expanded(
                  child: TextFormField(
                controller: inStock,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Instock', hintText: 'input Stock'),
              )),
              Expanded(
                  child: TextFormField(
                controller: totalinstock,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'total Instock', hintText: 'input total Stock'),
              )),
              Expanded(
                  child: TextFormField(
                controller: minsstock,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Minimal Stock',
                    hintText: 'input Minimal Stock'),
              )),
              Expanded(
                  child: TextFormField(
                controller: maxstock,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Maksimal Stock',
                    hintText: 'input Maksimal Stock'),
              )),
              Expanded(
                  child: TextFormField(
                controller: curpricelist,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'harga pembelian',
                    hintText: 'input harga pembelian'),
              )),
              Expanded(
                  child: Container(
                      padding: new EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: ButtonTheme(
                                  minWidth: 200.0,
                                  height: 100.0,
                                  child: TextButton(
                                    onPressed: () {
                                      if (barcode.text == "") {
                                        _alertFailed(
                                            context, "Barcode is mandatory");
                                      } else if (description.text == "") {
                                        _alertFailed(context,
                                            "Description is mandatory");
                                      } else {
                                        if (_valdead == "Yes") {
                                          _valdead = "1";
                                        } else {
                                          _valdead = "0";
                                        }
                                        _onsaved(
                                            barcode.text,
                                            description.text,
                                            _valgroup,
                                            _valgrade,
                                            satuan.text,
                                            qtySat.text,
                                            inStock.text,
                                            totalinstock.text,
                                            minsstock.text,
                                            maxstock.text,
                                            curpricelist.text,
                                            _date);

                                        _alertSave(context, "Save Successfuly");
                                      }
                                    },
                                    child: Text('Save',
                                        style: TextStyle(color: Colors.white)),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => Colors.redAccent)),
                                  )))
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
