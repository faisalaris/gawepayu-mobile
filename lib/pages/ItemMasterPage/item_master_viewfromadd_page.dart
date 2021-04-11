import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/Item%20Master/item_master_model.dart';
import './item_master_edit_page.dart';


// ignore: must_be_immutable
class ItemMasterViewfromAdd extends StatefulWidget {
ItemMasterRequestModel list;

  ItemMasterViewfromAdd({this.list});

  @override
  _ItemMasterViewState createState() => _ItemMasterViewState();
}

class _ItemMasterViewState extends State<ItemMasterViewfromAdd>
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
      onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => ItemEditMaster())),
      ),
      appBar: AppBar(
        title: Text(
          "Item Code : ${widget.list.code}",
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
              height: 600,
              padding: new EdgeInsets.all(32),
              child: new Row(children: <Widget>[
                Flexible(
                  child: new Container(
                    width: 400,
                    height: 600,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(
                          "Deskripsi : ${widget.list.description}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Barcode : ${widget.list.barcode}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Group : ${widget.list.group[0].gcode}" +" - "+ "${widget.list.group[0].longDesc}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Grade : ${widget.list.grade[0].gcode}" +" - "+ "${widget.list.grade[0].longDesc}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "IsDeadStock : ${widget.list.isdeadstock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Harga Beli : Rp. ${widget.list.curpricelist}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                new Container(
                    width: 400,
                    height: 600,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new Text(
                          "Quantity satuan : ${widget.list.qtySat}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Instock : ${widget.list.inStock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Total Instock : ${widget.list.totalInstock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Min stock : ${widget.list.minStock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Max stock : ${widget.list.maxStock}",
                          style: new TextStyle(
                              fontSize: 30.0, color: Colors.redAccent),
                        ),
                        Divider(),
                        new Text(
                          "Input Date : ${widget.list.inputDate}",
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
            SizedBox(
              height: 300.0,
              child :TabBarView
                        (controller:_controller ,
                        children: <Widget>[
                          Text("Price List"),
                          Text("Purchase List")
                       ]
                     )
            )
          ]
          )
      );
  }

}


  // ignore: must_be_immutable
  class SpriceList extends StatelessWidget {
  
  //List <SpriceList> _listprice = _ItemMasterViewState().getSprices();
 
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding : new EdgeInsets.all(32),
      child: new Center(
        child: new Column(
          children:<Widget> [
           DataTable(
             columns: [
               DataColumn(label: Text("Quantity")),
               DataColumn(label: Text("Harga")),
               DataColumn(label: Text("Tanggal Update"))
             ], 
             rows:[
               DataRow(cells: [
                 DataCell(
                    Text("data")
                 )
               ])
             ] 
             )
          ],
        ),
      )
    );
  }
    
  }