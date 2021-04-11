import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/Item Master/item_master_model.dart';
import 'package:editable/editable.dart';
import 'package:flutter_http_post_request/api/api_service.dart';
import 'package:flutter_http_post_request/model/GenSet/item_group_model.dart';
import 'package:flutter_http_post_request/model/GenSet/item_grade_model.dart';
import 'package:flutter_http_post_request/model/GenSet/item_satuan_model.dart';
import 'package:flutter_http_post_request/widget/text_dialog_widget.dart';
import 'package:flutter_http_post_request/pages/ItemMasterPage/Item_master_page.dart';
import 'package:flutter_http_post_request/ProgressHUD.dart';

class ItemEditMaster extends StatefulWidget {
  List<ItemMasterRequestModel> list;

  ItemEditMaster({this.list});

  @override
  _ItemEditMasterState createState() => _ItemEditMasterState();
}

class _ItemEditMasterState extends State<ItemEditMaster>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  bool isApiCallProcess = false;

  List<ItemMasterRequestModel> _itemmaster = [];

  List<SpriceList> _sPrice = [];
  List<SpriceList> _oldSPrice = [];
  List<SpriceList> _updateSPrice = [];
  List<SpriceList> _deletePrice = [];
  List<SpriceList> _addPrice = [];

  List<ItemGroupRequestModel> _listgroup = [];
  List<ItemGradeRequestModel> _listgrade = [];
  List<ItemSatuanRequestModel> _listSatuan = [];

  String _valgroup;
  String _valgrade;
  String _valsatuan;
  String _valdead = "0";

// master item controller
  var barcode = TextEditingController(text: "");
  var description = TextEditingController(text: "");
  var group = TextEditingController(text: "");
  var grade = TextEditingController(text: "");
  var isdeadstock = TextEditingController(text: "");
  var qtySat = TextEditingController(text: "");
  var inStock = TextEditingController(text: "");
  var totalinstock = TextEditingController(text: "");
  var minsstock = TextEditingController(text: "");
  var maxstock = TextEditingController(text: "");
  var curpricelist = TextEditingController(text: "");
  var satuan = TextEditingController(text: "");

String _date = DateTime.now().toIso8601String();

  // Price list Controller
var _addSpriceQty = TextEditingController(text: "0");
var _addSpricePrice = TextEditingController(text: "0");


  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _itemmaster.add(widget.list[0]);
    _sPrice.addAll(_itemmaster[0].sPriceList);
    _oldSPrice = _sPrice;
    _updateSPrice = _sPrice;

    APIServiceItemGroup apigroup = new APIServiceItemGroup();
    apigroup.getPost().then((value) {
      setState(() {
        _listgroup.addAll(value);
        _valgroup = _itemmaster[0].group[0].gcode;
      });
    });

    APIServiceItemGrade apigrade = new APIServiceItemGrade();
    apigrade.getPost().then((value) {
      setState(() {
        _listgrade.addAll(value);
        _valgrade = _itemmaster[0].grade[0].gcode;
      });
    });
  }

  refreshList() {
    setState(() {
      _updateSPrice = _updateSPrice;
      isApiCallProcess = false;
    });
  }

  _addDialog(BuildContext context)async{
    return showDialog(
      context :context,
      builder: (context){
      return AlertDialog(
       title: Text("Add Item"),
       content:
       SizedBox( height: 150, width: 100,
       child :
       Column(
       children: <Widget>[  
       TextFormField(
          controller: _addSpriceQty,
          decoration: InputDecoration(
            labelText: 'Quantity',
            border: OutlineInputBorder(),
          ),
          onSaved: (value) => _addSpriceQty.text = value  
      ),
      Divider(height:10 ),
      TextFormField(
          controller: _addSpricePrice,
          decoration: InputDecoration(
            labelText: 'Price',
            border: OutlineInputBorder(),
          ),  
      ),
       ])),
       actions: [
         ElevatedButton(
           child: Text('Add'),
           onPressed: (){
           String _datenow = DateTime.now().toIso8601String();   
           SpriceList _addpricelist = new SpriceList();
           _addpricelist.code = _itemmaster[0].code;
           _addpricelist.price = int.parse(_addSpricePrice.text);
           _addpricelist.qty =   int.parse(_addSpriceQty.text);
           _addpricelist.lastUpdate = _datenow;

           _updateSPrice.add(_addpricelist);
           refreshList();
           Navigator.pop(context);

           })
       ],
       );
      }
    );
  }

  @override
    Widget build(BuildContext context) {
    return ProgressHUD(
      child: _bodybuild(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3, 
    );
  }


  Widget _bodybuild(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title:
                Text('Edit Item master', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.redAccent,
            bottom: new TabBar(
              controller: _controller,
              tabs: [
                new Tab(
                  icon: const Icon(Icons.receipt),
                  text: 'Item Master',
                ),
                new Tab(
                  icon: const Icon(Icons.receipt),
                  text: 'Selling Price List',
                ),
              ],
            )),
        body: new TabBarView(controller: _controller, children: <Widget>[
          new SingleChildScrollView(
              child: new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Form(
              child: new Column(
                children: <Widget>[
                  TextFormField(
                      controller: description,
                      decoration: InputDecoration(
                          labelText: 'Deskrpsi : ${widget.list[0].description}',
                          hintText: 'update deskripsi'),
                      onSaved: (value) => description.text = value),
                  TextFormField(
                      controller: barcode,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Barcode : ${widget.list[0].barcode}',
                          hintText: 'update barcode'),
                      onSaved: (value) => barcode.text = value),
                  Container(
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
                                    child: Text(
                                        item.code + '-' + item.description),
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
                  ),
                  Container(
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
                                    child: Text(
                                        item.code + '-' + item.description),
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
                  ),
                  TextFormField(
                      controller: isdeadstock,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText:
                              'dead stock : ${widget.list[0].isdeadstock.toString()} ( 1 = Yes , 0 = No )',
                          hintText: 'update dead Stock '),
                      onSaved: (value) => isdeadstock.text = value),
                  TextFormField(
                      controller: qtySat,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText:
                              'Quantity satuan : ${widget.list[0].qtySat.toString()}',
                          hintText: 'update Quantity satuan '),
                      onSaved: (value) => qtySat.text = value),
                  TextFormField(
                      controller: satuan,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText:
                              'Satuan : ${widget.list[0].satuan.toString()}',
                          hintText: 'update Satuan '),
                      onSaved: (value) => satuan.text = value),
                  TextFormField(
                      controller: inStock,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText:
                              'inStock : ${widget.list[0].inStock.toString()}',
                          hintText: 'update inStock '),
                      onSaved: (value) => inStock.text = value),
                  TextFormField(
                      controller: totalinstock,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText:
                              'Total InStock : ${widget.list[0].totalInstock.toString()}',
                          hintText: 'update inStock '),
                      onSaved: (value) => totalinstock.text = value),
                  TextFormField(
                      controller: minsstock,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText:
                              'minStock : ${widget.list[0].minStock.toString()}',
                          hintText: 'update minimal stock '),
                      onSaved: (value) => minsstock.text = value),
                  TextFormField(
                      controller: maxstock,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText:
                              'maxstock : ${widget.list[0].maxStock.toString()}',
                          hintText: 'update maksimal stock '),
                      onSaved: (value) => minsstock.text = value),
                  TextFormField(
                      controller: curpricelist,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText:
                              'Harga pembelian : ${widget.list[0].curpricelist.toString()}',
                          hintText: 'update Harga pembelian '),
                      onSaved: (value) => curpricelist.text = value),
                ],
              ),
            ),
          )),
          new SingleChildScrollView(
              child: new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Form(
                      child: new Column(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.add), onPressed: () {
                            _addDialog(context);
                          }),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                DataTable(columns: [
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("Quantity")),
                                  DataColumn(label: Text("Harga")),
                                  //DataColumn(label: Text("Status"))
                                ], rows: getRows(context, _updateSPrice)),
                                ButtonTheme(
                                    minWidth: 200.0,
                                    height: 100.0,
                                    child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text("INFO"),
                                                    content: Text(
                                                        "Tombol ini akan memproses data edit, delete dan add yang sudah dilakukan"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            isApiCallProcess = true;
                                                             ItemMasterPutModel _updateItemmaster = new ItemMasterPutModel();
                                                             _updateItemmaster.parent = _itemmaster[0].parent;
                                                             _updateItemmaster.openingBalanceStocks = _itemmaster[0].openingBalanceStocks;
                                                             _updateItemmaster.prefix = _itemmaster[0].prefix;
                                                             _updateItemmaster.code = _itemmaster[0].code;
                                                             if (description.text ==""){
                                                              _updateItemmaster.description = _itemmaster[0].description;
                                                             }
                                                             else{
                                                               _updateItemmaster.description =description.text;
                                                             }

                                                             if (barcode.text ==""){
                                                              _updateItemmaster.barcode = _itemmaster[0].barcode;
                                                             }
                                                             else{
                                                               _updateItemmaster.barcode =barcode.text;
                                                             }

                                                            _updateItemmaster.group = _valgroup;
                                                            _updateItemmaster.grade = _valgrade;

                                                             if (isdeadstock.text ==""){
                                                              _updateItemmaster.isdeadstock = _itemmaster[0].isdeadstock;
                                                             }
                                                             else{
                                                               _updateItemmaster.isdeadstock =isdeadstock.text;
                                                             }

                                                            if (qtySat.text ==""){
                                                              _updateItemmaster.qtySat = _itemmaster[0].qtySat;
                                                             }
                                                             else{
                                                               _updateItemmaster.qtySat =int.parse(qtySat.text);
                                                             }
                                                             
                                                            if (inStock.text ==""){
                                                              _updateItemmaster.inStock = _itemmaster[0].inStock;
                                                             }
                                                             else{
                                                               _updateItemmaster.inStock =int.parse(inStock.text);
                                                             }

                                                            if (inStock.text ==""){
                                                              _updateItemmaster.inStock = _itemmaster[0].inStock;
                                                             }
                                                             else{
                                                               _updateItemmaster.inStock =int.parse(inStock.text);
                                                             }

                                                            if (totalinstock.text ==""){
                                                              _updateItemmaster.totalInstock = _itemmaster[0].totalInstock;
                                                             }
                                                             else{
                                                               _updateItemmaster.totalInstock =int.parse(totalinstock.text);
                                                             }

                                                            if (minsstock.text ==""){
                                                              _updateItemmaster.minStock = _itemmaster[0].minStock;
                                                             }
                                                             else{
                                                               _updateItemmaster.minStock =int.parse(minsstock.text);
                                                             }

                                                            if (maxstock.text ==""){
                                                              _updateItemmaster.maxStock = _itemmaster[0].maxStock;
                                                             }
                                                             else{
                                                               _updateItemmaster.maxStock =int.parse(maxstock.text);
                                                             }

                                                            if (maxstock.text ==""){
                                                              _updateItemmaster.maxStock = _itemmaster[0].maxStock;
                                                             }
                                                             else{
                                                               _updateItemmaster.maxStock =int.parse(maxstock.text);
                                                             }

                                                             if (curpricelist.text ==""){
                                                              _updateItemmaster.curpricelist = _itemmaster[0].curpricelist;
                                                             }
                                                             else{
                                                               _updateItemmaster.curpricelist =int.parse(curpricelist.text);
                                                             }

                                                             if (satuan.text ==""){
                                                              _updateItemmaster.satuan = _itemmaster[0].satuan;
                                                             }
                                                             else{
                                                               _updateItemmaster.satuan =satuan.text;
                                                             }

                                                              _updateItemmaster.inputDate =_date;
                                                              _updateItemmaster.sPriceList =[];

                                                              //for (int i = 0; i < _updateSPrice.length; i++) {
                                                                //    _updateSPrice[i].qty = double.parse(_updateSPrice[i].qty) ;
                                                                  //  _updateSPrice[i].price = double.parse(_updateSPrice[i].price);
                                                              //}

                                                              _updateItemmaster.sPriceList.addAll(_updateSPrice);
                                                               APIServiceItemMasterPut apiput = new APIServiceItemMasterPut();
                                                               apiput.tojson(_updateItemmaster);

                                                                if (_deletePrice.length > 0) {
                                                                    for (int i = 0; i < _deletePrice.length; i++) {
                                                                    APIServicePriceListDelete apidelete = new APIServicePriceListDelete();
                                                                    apidelete.deleteJson(_deletePrice[i].id);
                                                                    }
                                                                }
                                                                                                                            
                                                               isApiCallProcess = false; 
                                                             Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ItemMaster()));
                                                          },
                                                          child: Text(
                                                              "Lanjutkan Proses")),
                                                      TextButton(
                                                          onPressed: () {
                                                             Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Kembali"))
                                                    ]);
                                              });
                                        },
                                        child: Text('Proses',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) =>
                                                        Colors.red))))
                              ])
                        ])
                  ])))),
        ]));
  }

  List<DataRow> getRows(BuildContext context, List<SpriceList> _sprice) =>
      _sprice.map((SpriceList sPrice) {
        final cells = ["Hapus", sPrice.qty, sPrice.price];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            final showEditIcon = index == 1 || index == 2;

            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                switch (index) {
                  case 0:
                    for (int i = 0; i < _sprice.length; i++) {
                      if (_sprice.elementAt(i).id == sPrice.id) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text("Hapus Data"),
                                  content: Text("Yakin akan di hapus"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _deletePrice
                                              .add(_sprice.elementAt(i));
                                          _sprice.removeAt(i);
                                          refreshList();
                                        },
                                        child: Text("Ok")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"))
                                  ]);
                            });
                      }
                    }

                    break;
                  case 1:
                    editQty(sPrice);
                    break;
                  case 2:
                    editPrice(sPrice);
                    break;
                  //case 3 :
                   // updateStatusPrice(sPrice);
                   // break;
                }
              },
            );
          }),
        );
      }).toList();

  Future editQty(SpriceList editQty) async {
    final qty = await showTextDialog(
      context,
      title: 'Change Quantity',
      value: editQty.qty.toString(),
    );
    final id = editQty.id;
    final code = editQty.code;
    final lastUpdate = DateTime.now().toIso8601String();
 

    setState(() => _updateSPrice = _updateSPrice.map((editqty) {
          final isEditedqty = editqty == editQty;

          return isEditedqty ? editqty.copy(id: id,code: code,qty: double.parse(qty),lastUpdate: lastUpdate) : editqty;
        }).toList());
  }


  Future editPrice(SpriceList editPrice) async {
    final price = await showTextDialog(
      context,
      title: 'Change Price',
      value: editPrice.price.toString(),
    );

    setState(() => _updateSPrice = _updateSPrice .map((editprice) {
          final isEditedprice = editprice == editPrice;

          return isEditedprice ? editprice.copy(price: double.parse(price)) : editprice;
        }).toList());
  }
}

class Utils {
  static List<T> modelBuilder<M, T>(
          List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
