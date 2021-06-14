import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/Item%20Master/item_master_model.dart';
import './item_master_edit_page.dart';

// ignore: must_be_immutable
class ItemMasterViewadd2 extends StatefulWidget {
  List<ItemMasterRequestModel> list;
  String barcode ;
  
  ItemMasterViewadd2({this.list,this.barcode});

  @override
  _ItemMasterViewaddState createState() => _ItemMasterViewaddState();
}

class _ItemMasterViewaddState extends State<ItemMasterViewadd2>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<ItemMasterRequestModel> _itemmaster =[];
  List<ItemMasterRequestModel> _filterItemmaster =[];
  List<SpriceList> _sPrice=[];
  List<PpriceList> _pPrice=[];

  String _dead ="";

  @override
  void initState() {  
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _itemmaster.addAll(widget.list);
    List<ItemMasterRequestModel> tempList = [];
                   for (int i = 0; i < _itemmaster.length; i++) {
                   if (_itemmaster.elementAt(i).barcode == widget.barcode){
                      tempList.add(_itemmaster.elementAt(i));
                   }

                   }
                    _filterItemmaster = tempList ;
    _sPrice.addAll(_filterItemmaster[0].sPriceList);
    _pPrice.addAll(_filterItemmaster[0].pPriceList);
  }

  void _change (String code){
    setState(() {
      if(code == '0'){
        _dead = 'No';
      }
      else{
        _dead = 'Yes';
      }
      return _dead;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          backgroundColor: Colors.redAccent,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ItemEditMaster(list:_filterItemmaster,))),
        ),
        appBar: AppBar(
          title: Text(
            "Item Code : ${_filterItemmaster[0].code}",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
        backgroundColor: Colors.white,
        body: new Column(children: <Widget>[
          Row(children: <Widget>[
            Flexible(
                child: new Container(
              width: 800,
              height: 500,
              padding: new EdgeInsets.all(32),
              child: new Row(children: <Widget>[
                Flexible(
                  child: new Container(
                    width: 400,
                    height: 500,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:_filterItemmaster[0].description ,
                          decoration: InputDecoration(
                            labelText: 'Deskripsi',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:_filterItemmaster[0].barcode ,
                          decoration: InputDecoration(
                            labelText: 'Barcode',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:_filterItemmaster[0].group[0].gcode +" - "+_filterItemmaster[0].group[0].longDesc ,
                          decoration: InputDecoration(
                            labelText: 'Group',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:_filterItemmaster[0].grade[0].gcode +" - "+_filterItemmaster[0].grade[0].longDesc ,
                          decoration: InputDecoration(
                            labelText: 'Grade',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue: _filterItemmaster[0].isdeadstock,
                          decoration: InputDecoration(
                            labelText: 'Stock mati',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue: 'Rp. ' + _filterItemmaster[0].curpricelist.toString(),
                          decoration: InputDecoration(
                            labelText: 'Harga Beli',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                new Container(
                    width: 400,
                    height: 500,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  _filterItemmaster[0].qtySat.toString(),
                          decoration: InputDecoration(
                            labelText: 'Quantity Satuan',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  _filterItemmaster[0].inStock.toString(),
                          decoration: InputDecoration(
                            labelText: 'InStock',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  _filterItemmaster[0].totalInstock.toString(),
                          decoration: InputDecoration(
                            labelText: 'Total Instock',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  _filterItemmaster[0].minStock.toString(),
                          decoration: InputDecoration(
                            labelText: 'MinStock',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  _filterItemmaster[0].maxStock.toString(),
                          decoration: InputDecoration(
                            labelText: 'MaxStock',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  _filterItemmaster[0].inputDate,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Input',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                      ],
                    )),
              ]),
            ))
          ]),
          Row(
            children: <Widget>[
              Flexible(
                child: Column(children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor),
                    child: new TabBar(
                      controller: _controller,
                      tabs: [
                        new Tab(
                          icon: const Icon(Icons.receipt),
                          text: 'Selling Price List',
                        ),
                        new Tab(
                          icon: const Icon(Icons.receipt),
                          text: 'Purchasing Price List',
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
          Expanded (child:
          SizedBox(
              height: 400.0,
              child: TabBarView(controller: _controller, 
              children: <Widget>[
                // Selling Price
                    DataTable(
                    columns: [
                      DataColumn(label: Text("Quantity")),
                      DataColumn(label: Text("Harga")),
                      DataColumn(label: Text("Tanggal Update"))
                    ],
                    rows: _sPrice
                        .map(
                          (price) => DataRow(cells: [
                            DataCell(
                              Text(price.qty.toString()),
                            ),
                            DataCell(
                              Text(price.price.toString()),
                            ),
                            DataCell(
                              Text(price.lastUpdate),
                            ),
                          ])
                        )
                        .toList()),
                // Purchasing Price
                //Text("data")
                     DataTable(
                    columns: [
                      DataColumn(label: Text("Vendor")),
                      DataColumn(label: Text("Harga")),
                      DataColumn(label: Text("Tanggal Update"))
                    ],
                    rows: _pPrice
                        .map(
                          (price) => DataRow(cells: [
                            DataCell(
                              Text(price.businessP[0].desc),
                            ),
                            DataCell(
                              Text(price.price.toString()),
                            ),
                            DataCell(
                              Text(price.lastPurchase),
                            ),
                          ])
                        )
                        .toList()),
                
  
              ]
              )
              )
    )]));
  }
}

