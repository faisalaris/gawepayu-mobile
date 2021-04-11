import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/Item%20Master/item_master_model.dart';
import './item_master_edit_page.dart';

// ignore: must_be_immutable
class ItemMasterView extends StatefulWidget {
  List<ItemMasterRequestModel> list;
  int index;

  ItemMasterView({this.list, this.index});

  @override
  _ItemMasterViewState createState() => _ItemMasterViewState();
}

class _ItemMasterViewState extends State<ItemMasterView>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<ItemMasterRequestModel> _itemmaster =[];
  List<SpriceList> _sPrice=[];
  List<PpriceList> _pPrice=[];

  String _dead ="";

  @override
  void initState() {  
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _itemmaster.add(widget.list[widget.index]);
    _sPrice.addAll(_itemmaster[0].sPriceList);
    _pPrice.addAll(_itemmaster[0].pPriceList);
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
              MaterialPageRoute(builder: (context) => ItemEditMaster(list:_itemmaster,))),
        ),
        appBar: AppBar(
          title: Text(
            "Item Code : ${widget.list[widget.index].code}",
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
                          initialValue:widget.list[widget.index].description ,
                          decoration: InputDecoration(
                            labelText: 'Deskripsi',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:widget.list[widget.index].barcode ,
                          decoration: InputDecoration(
                            labelText: 'Barcode',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:widget.list[widget.index].group[0].gcode +" - "+widget.list[widget.index].group[0].longDesc ,
                          decoration: InputDecoration(
                            labelText: 'Group',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:widget.list[widget.index].grade[0].gcode +" - "+widget.list[widget.index].grade[0].longDesc ,
                          decoration: InputDecoration(
                            labelText: 'Grade',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue: widget.list[widget.index].isdeadstock,
                          decoration: InputDecoration(
                            labelText: 'Stock mati',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue: 'Rp. ' + widget.list[widget.index].curpricelist.toString(),
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
                          initialValue:  widget.list[widget.index].qtySat.toString(),
                          decoration: InputDecoration(
                            labelText: 'Quantity Satuan',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  widget.list[widget.index].inStock.toString(),
                          decoration: InputDecoration(
                            labelText: 'InStock',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  widget.list[widget.index].totalInstock.toString(),
                          decoration: InputDecoration(
                            labelText: 'Total Instock',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  widget.list[widget.index].minStock.toString(),
                          decoration: InputDecoration(
                            labelText: 'MinStock',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  widget.list[widget.index].maxStock.toString(),
                          decoration: InputDecoration(
                            labelText: 'MaxStock',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  widget.list[widget.index].inputDate,
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

