import 'package:flutter/material.dart';

class ItemEditMaster extends StatefulWidget {
  @override
  _ItemEditMasterState createState() => _ItemEditMasterState();
}


class _ItemEditMasterState extends State<ItemEditMaster> {

  TextEditingController _code = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit Item master'),
      ),
      body: new Column(
        children:<Widget> [
         Container (   
          padding: new EdgeInsets.all(32.0),
          child :new Row (
            children: <Widget>[
              Container(height: 500, width: 300, color: Colors.red),
                      SizedBox(width: 20,),
                      Container(height: 500, width: 300, color: Colors.green)
            ],
              )
         ),
         SizedBox(width: 20,),
         Container (height: 500, width: 300,color: Colors.blueAccent
         )
         ]  
      ),
    ) ;
  }

}