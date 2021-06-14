import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/PO/po_master_model.dart';
import 'package:flutter_http_post_request/model/Item Master/item_master_model.dart';
import './po_master_edit_page.dart';
import './po_master_QR_page.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';


// ignore: must_be_immutable
class PoMasterView extends StatefulWidget {
  List<PoMasterRequestModel> list;
  List<ItemMasterRequestModel> item;
  int index;

  PoMasterView({this.list,this.item, this.index});

  @override
  _PoMasterViewState createState() => _PoMasterViewState();
}

class _PoMasterViewState extends State<PoMasterView>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<PoMasterRequestModel> _pomaster =[];
  List<PoTransDetail> _pOtrans=[];

  String _dead ="";

  @override
  void initState() {  
    super.initState();
    _controller = new TabController(length: 1, vsync: this);
    _pomaster.add(widget.list[widget.index]);
    _pOtrans.addAll(_pomaster[0].poTransDet);
    _change(_pomaster[0].posted);

  }

  _change (String code){
    
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


    Widget _getTitleItemWidget(String label, double width,color) {
    return Container(
      color: color,
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

    Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      color: Colors.blueGrey,
      child: Text(_pOtrans[index].itemCode[0].description,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
      width: 120,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

   Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(_pOtrans[index].qty.toString(),style: TextStyle(fontSize: 18),),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(width: 2,height: 56,color: Colors.blueGrey,),
        Container(
          child: Text(_pOtrans[index].price.toString(),style: TextStyle(fontSize: 18),),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(width: 2,height: 56,color: Colors.blueGrey,),
        Container(
          child: Text(_pOtrans[index].totalPrice.toString(),style: TextStyle(fontSize: 18),),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(width: 2,height: 56,color: Colors.blueGrey,),
        Container(
          child: Text(_pOtrans[index].disc1.toString(),style: TextStyle(fontSize: 18),),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(width: 2,height: 56,color: Colors.blueGrey,),
        Container(
          child: Text(_pOtrans[index].totalDisc.toString(),style: TextStyle(fontSize: 18),),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(width: 2,height: 56,color: Colors.blueGrey,),
        Container(
          child: Text(_pOtrans[index].ppn.toString(),style: TextStyle(fontSize: 18),),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Item Description', 200,Colors.red),
      Container(width: 2,height: 56,color: Colors.white,),
      _getTitleItemWidget('Quantity', 100,Colors.red),
      Container(width: 2,height: 56,color: Colors.white,),
      _getTitleItemWidget('Price', 100,Colors.red),
      Container(width: 2,height: 56,color: Colors.white,),
      _getTitleItemWidget('Total Price', 100,Colors.red),
      Container(width: 2,height: 56,color: Colors.white,),
      _getTitleItemWidget('Discount', 100,Colors.red),
      Container(width: 2,height: 56,color: Colors.white,),
      _getTitleItemWidget('Total Discount', 100,Colors.red),
      Container(width: 2,height: 56,color: Colors.white,),
      _getTitleItemWidget('ppn', 100,Colors.red),
      Container(width: 2,height: 56,color: Colors.white,),
    ];
  }


 Widget _getBodyWidget() {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 200,
        rightHandSideColumnWidth: 700,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: _pOtrans.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
      ),
      height: 400,
      // height: MediaQuery
      //     .of(context)
      //     .size
      //     .height,
    );
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
          onPressed: ()  => Navigator.push(context,
              MaterialPageRoute(builder: (context) => POEditMaster(list:_pomaster,item:widget.item))),
        ),
        appBar: AppBar(
          title: Text(
            "Docnum : ${widget.list[widget.index].docNum.toString()}",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          actions: [
          IconButton(icon: Icon(Icons.qr_code), 
          onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => GenQRCode(list:_pomaster,)))),
          ],
        ),
        backgroundColor: Colors.white,
        body: 
        SingleChildScrollView(
        scrollDirection: Axis.vertical,  
        child :
        SingleChildScrollView(
         scrollDirection: Axis.horizontal,
         child :
        Container(
        width :MediaQuery.of(context).size.width,
        height :MediaQuery.of(context).size.height,
        child :  
        new Column(children: <Widget>[
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
                          initialValue:widget.list[widget.index].docNum.toString() ,
                          decoration: InputDecoration(
                            labelText: 'Document Number',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:widget.list[widget.index].bpCode[0].code ,
                          decoration: InputDecoration(
                            labelText: 'Business Partner Code',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:widget.list[widget.index].bpCode[0].desc ,
                          decoration: InputDecoration(
                            labelText: 'Business Partner',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:widget.list[widget.index].docDate ,
                          decoration: InputDecoration(
                            labelText: 'Document Date',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue: widget.list[widget.index].postedDate,
                          decoration: InputDecoration(
                            labelText: 'Posted Date',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                        new TextFormField(
                          enabled: false,
                          style:TextStyle(color:Colors.redAccent),
                          initialValue:  _dead,
                          decoration: InputDecoration(
                            labelText: 'Posted',
                            labelStyle: TextStyle(color:Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                          text: 'Details',
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
        _getBodyWidget()
    ])))));
  }
}

