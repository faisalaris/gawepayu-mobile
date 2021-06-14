import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/image.dart';
import 'package:flutter_http_post_request/pages/ItemMasterPage/Item_master_page.dart';
import 'package:flutter_http_post_request/pages/POPage/po_master_page.dart';
import 'package:flutter_http_post_request/controller/headermenu.dart';
import 'package:flutter_http_post_request/ProgressHUD.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double _scale = 1.5;



  @override  
   Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen = mediaQueryData.size.height - paddingBottom - appBarHeight;

    return Scaffold(
      appBar: actionHeadMenu('Menu'),
      backgroundColor: Colors.white,
      body: Center(
        child : Column(// Bungkus GridView dengan ini
        children: <Widget>[
        Expanded(  
        child :GridView.count(
          crossAxisCount: 3,
          childAspectRatio: widthScreen/heightScreen,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color:Colors.redAccent,width: 5),
                shape: BoxShape.circle,
                image:DecorationImage(image: AssetImage('images/icon5.png',),
                scale: _scale,
                ),
                color: Colors.white,
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                new TextButton(onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => ItemMaster(deadstock:'0'))),style:TextButton.styleFrom(backgroundColor: Colors.redAccent), child:  Text("Item Master",
                  style: TextStyle(fontSize: 24.0,color: Colors.white)
                  ),
                ),
                ]
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color:Colors.redAccent,width: 5),
                shape: BoxShape.circle,
                image:DecorationImage(image: AssetImage('images/icon5.png',),
                scale: _scale,
                ),
                color: Colors.white,
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Wrap(
                  children: <Widget>[
                new TextButton(onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => ItemMaster(deadstock:'1'))),style:TextButton.styleFrom(backgroundColor: Colors.redAccent), child:  Text("Not Active Item Master",
                  style: TextStyle(fontSize: 16.0,color: Colors.white)
                  ),
                )
                ]
                ),
                ]
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color:Colors.redAccent,width: 5),
                shape: BoxShape.circle,
                image:DecorationImage(image: AssetImage('images/icon5.png',),
                scale: _scale, 
                ),
                color: Colors.white,
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                new TextButton(onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => PoMaster())),style:TextButton.styleFrom(backgroundColor: Colors.redAccent), child:  Text("Purchase Order",
                  style: TextStyle(fontSize: 24.0,color: Colors.white)
                  ),
                ),
                ]
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color:Colors.redAccent,width: 5),
                shape: BoxShape.circle,
                image:DecorationImage(image: AssetImage('images/icon5.png',),
                scale: _scale, 
                
                ),
                color: Colors.white,
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                new TextButton(onPressed: (){},style:TextButton.styleFrom(backgroundColor: Colors.redAccent), child:  Text("Good Receipt",
                  style: TextStyle(fontSize: 24.0,color: Colors.white)
                  ),
                ),
                ]
              ),
            ),
          ],
        ),
        )]),
    )
    );
  }

  
}
