import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/item_master_model.dart';
import 'package:http/http.dart' as http;
import '../api/api_service.dart';
import '../model/item_group_model.dart';
import '../model/item_grade_model.dart';
import '../model/item_master_model.dart';
import '../pages/item_master_page.dart';

class ItemAddMaster extends StatefulWidget {
  @override
  _ItemAddMasterState createState() => _ItemAddMasterState();
}

class _ItemAddMasterState extends State<ItemAddMaster> {

      var formKey = GlobalKey<FormState>();
      var code =TextEditingController();
      var barcode = TextEditingController();
      var description = TextEditingController();
      var group = TextEditingController();
      var grade = TextEditingController();
      var isdeadstock =TextEditingController();
      var qtySat = TextEditingController(text:'1');
      var inStock = TextEditingController(text: '0');
      var totalinstock = TextEditingController(text: '0');
      var minsstock =TextEditingController(text: '0');
      var maxstock = TextEditingController(text: '0');
      var curpricelist = TextEditingController(text: '0');


      String _valgroup ;
      String _valgrade ;
      String _valDead  ;

      List <dynamic> _listgroup = [];
      List <ItemGradeRequestModel> _listgrade = [];
      List <String> _listdead =['0','1'];
      Uri url = new Uri.http(web,'/itemgroup');
      Uri urlgrade = new Uri.http(web,'/itemgrade');
      
    void getgroup() async {
    final respose = await http.get(url); 
    List <ItemGroupRequestModel> listData = itemGroupPostFromJson(respose.body);  
    setState(() {
      _listgroup = listData; 
    });
    print("data : $listData");
  }

    void getgrade() async {
    final respose = await http.get(urlgrade); 
    List <ItemGradeRequestModel> listData = itemGradePostFromJson(respose.body);  
    setState(() {
      _listgrade = listData; 
    });
    print("data : $listData");
  }

  Future _alertSave(BuildContext context,String message) async {
    return showDialog (
      context: context,
      builder : (BuildContext context) {
        return AlertDialog(
          title: Text("Info"),
          content: Text(message),
          actions : [
          TextButton(onPressed:(){Navigator.push(context,MaterialPageRoute(builder: (context) => ItemMaster()));} , 
          child: Text("Ok"))
          ]
              );
          }
        );
      }
  
  Future _alertFailed(BuildContext context,String message) async {
    return showDialog (
      context: context,
      builder : (BuildContext context) {
        return AlertDialog(
          title: Text("Info"),
          content: Text(message),
          actions : [
          TextButton(onPressed:(){Navigator.pop(context);} , 
          child: Text("Ok"))
          ]
              );
          }
        );
      }

      
  void _onsaved(
    String code,
    String barcode,
    String description,
    String group,
    String grade,
    dynamic isdeadstock,
    dynamic qtysat,
    dynamic instock,
    dynamic totalInstock,
    dynamic minStock,
    dynamic maxStock,
    dynamic curpricelist
    )
    { 
      setState(() {
      ItemMasterRequestModel itemMaster = new ItemMasterRequestModel() ;
      APIServiceItemMasterPost apiItemPost = new APIServiceItemMasterPost();
      itemMaster.code = code;
      itemMaster.barcode =barcode;
      itemMaster.description = description ;
      itemMaster.group = group;
      itemMaster.grade = grade;
      itemMaster.isdeadstock = isdeadstock;
      itemMaster.qtySat = qtysat;
      itemMaster.inStock = instock;
      itemMaster.totalInstock = totalInstock;
      itemMaster.minStock = minStock;
      itemMaster.maxStock = maxStock;
      itemMaster.curpricelist = curpricelist;

      apiItemPost.tojson(itemMaster);
    });
        
  }
  
   @override
    void initState() {
      super.initState();
      getgroup();
      getgrade();
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
                          Expanded(
                            child: 
                           TextFormField(
                             controller : code,
                             decoration : InputDecoration(
                               labelText: 'Code',
                               hintText: 'input Code'
                             ),
                             validator: (value){
                               if (value == null) {
                                 return 'Code harus di input';
                               }
                               return null ;
                             },
                             onSaved : (value) => code.text = value
                           )
                          ),
                          Expanded(child: 
                           TextFormField(
                             controller : barcode,
                             decoration : InputDecoration(
                               labelText: 'Barcode',
                               hintText: 'input barcode'
                             ),
                             validator: (value){
                               if (value == null) {
                                 return 'Barcode harus di input';
                               }
                               return null ;
                             },
                               onSaved : (value) => barcode.text = value
                           )
                          ),
                           TextFormField(
                             controller : description,
                             decoration : InputDecoration(
                               labelText: 'Deskripsi',
                               hintText: 'input Deskripsi'
                             ),
                             validator: (value){
                               if (value == null) {
                                 return 'Deskripsi harus di input';
                               }
                               return null ;
                             },
                                onSaved : (value) => description.text = value
                           ),
                           Expanded(child: 
                           Container(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 DropdownButton(
                                   isExpanded: true,
                                   hint: Text("pilih Group"),
                                   value: _valgroup,
                                   items: _listgroup.map((item){
                                    return DropdownMenuItem(
                                      child: Text(item.code),
                                      value: item.code
                                    ); 
                                   },
                                 ).toList(),
                                 onChanged: (value){
                                   setState(() {
                                     _valgroup = value;
                                   });
                                 },
                                 )
                               ]
                             ),
                           )
                           ),
                             Expanded(child: 
                             Container(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 DropdownButton(
                                   isExpanded: true,
                                   hint: Text("pilih Grade"),
                                   value: _valgrade,
                                   items: _listgrade.map((item){
                                    return DropdownMenuItem(
                                      child: Text(item.code),
                                      value: item.code
                                    ); 
                                   },
                                 ).toList(),
                                 onChanged: (value){
                                   setState(() {
                                     _valgrade = value;
                                   });
                                 },
                                 )
                               ]
                             ),
                           )
                             ),
                             Expanded(child: 
                             Container(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 DropdownButton(
                                   isExpanded: true,
                                   hint: Text("Dead Stock"),
                                   value: _valDead,
                                   items: _listdead.map((value){
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value
                                    ); 
                                   },
                                 ).toList(),
                                 onChanged: (value){
                                   setState(() {
                                     _valDead = value;
                                   });
                                 },
                                 )
                               ]
                             ),
                           )
                             ),
                             Expanded(child: 
                           TextFormField(      
                             controller : qtySat,
                             keyboardType: TextInputType.phone,
                             decoration : InputDecoration(
                               labelText: 'Quantity Satuan',
                               hintText: 'input Quantity Satuan'
                             ),
                           )
                             ),
                             Expanded(child:
                           TextFormField(      
                             controller : inStock,
                             keyboardType: TextInputType.phone,
                             decoration : InputDecoration(
                               labelText: 'Instock',
                               hintText: 'input Stock'
                             ),
                           )
                             ),
                             Expanded(child: 
                           TextFormField(      
                             controller : totalinstock,
                             keyboardType: TextInputType.phone,
                             decoration : InputDecoration(
                               labelText: 'total Instock',
                               hintText: 'input total Stock'
                             ),
                           )
                             ),
                          Expanded(child: 
                          TextFormField(      
                             controller : minsstock,
                             keyboardType: TextInputType.phone,
                             decoration : InputDecoration(
                               labelText: 'Minimal Stock',
                               hintText: 'input Minimal Stock'
                             ),
                           )
                          ),
                          Expanded(child: 
                          TextFormField(      
                             controller : maxstock,
                             keyboardType: TextInputType.phone,
                             decoration : InputDecoration(
                               labelText: 'Maksimal Stock',
                               hintText: 'input Maksimal Stock'
                             ),
                           )
                          ),
                          Expanded(child: 
                          TextFormField(      
                             controller : curpricelist,
                             keyboardType: TextInputType.phone,
                             decoration : InputDecoration(
                               labelText: 'harga pembelian',
                               hintText: 'input harga pembelian'
                             ),
                           )
                          ),
                          Expanded(child: 
                           Container(
                             padding: new EdgeInsets.all(20),
                             child: Column(
                               children:<Widget> [
                                 Expanded(child: 
                                 ButtonTheme(
                                   minWidth: 200.0,
                                  height: 100.0,
                                   child: TextButton(
                                   onPressed: (){ 
                                     
                                     if (code.text == ""){
                                        _alertFailed(context,"Code is mandatory");
                                     }
                                      else if (barcode.text == ""){
                                        _alertFailed(context,"Barcode is mandatory");
                                      }
                                      else if (description.text == ""){
                                        _alertFailed(context,"Description is mandatory");
                                      }
                                      else {
                                     _onsaved(code.text, barcode.text, description.text, _valgroup, _valgrade, _valDead , 
                                     qtySat.text, inStock.text, totalinstock.text, minsstock.text, maxstock.text, curpricelist.text);
                                   _alertSave(context,"Save Successfuly");
                                      }                                                                                 
                                   }, 
                                   child: Text('Save',style: TextStyle(color:Colors.white)
                                   ),
                                   style: ButtonStyle(backgroundColor:MaterialStateProperty.resolveWith((states) => Colors.redAccent) ),
                                   )
                                 )
                                 )
                               ],
                             )
                           )
                          )
                         ],
                       ),
                     ),
                   ),
                 ) ;
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

