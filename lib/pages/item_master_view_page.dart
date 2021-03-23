import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/item_master_model.dart';


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

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton
      (child:Icon(Icons.edit,color: Colors.white,) ,
      backgroundColor: Colors.redAccent,
      onPressed: (){},
      ),
      appBar: AppBar(
        title: Text(
          "Item Code : ${widget.list[widget.index].code}",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      backgroundColor: Colors.white,
      body: new Column(
        children: <Widget>[
          Row(children: <Widget>[
            Flexible(
                child: new Container(
              width: 800,
              height: 400,
              padding: new EdgeInsets.all(32),
              child: new Row(children: <Widget>[
                Flexible(
                  child: new Container(
                    width: 400,
                    height: 400,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(
                          "Deskripsi : ${widget.list[widget.index].description}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Barcode : ${widget.list[widget.index].barcode}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Group : ${widget.list[widget.index].group}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Grade : ${widget.list[widget.index].grade}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "IsDeadStock : ${widget.list[widget.index].isdeadstock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Harga Beli : Rp. ${widget.list[widget.index].curpricelist}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                ),
                new Container(
                    width: 400,
                    height: 400,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(
                          "Quantity satuan : ${widget.list[widget.index].qtySat}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Instock : ${widget.list[widget.index].inStock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Total Instock : ${widget.list[widget.index].totalInstock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Min stock : ${widget.list[widget.index].minStock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Max stock : ${widget.list[widget.index].maxStock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
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
                  decoration:
                      new BoxDecoration(color: Theme.of(context).primaryColor),
                  child: new TabBar(
                    controller: _controller,
                    tabs: [
                      new Tab(
                        icon: const Icon(Icons.home),
                        text: 'Address',
                      ),
                      new Tab(
                        icon: const Icon(Icons.my_location),
                        text: 'Location',
                      ),
                    ],
                  ),
                ),
              ]),
              )
            ],
          ),

          ]
          )
      );
  }
}
