import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:flutter_http_post_request/pages/Item_master_page.dart';
import '../controller/headermenu.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Center( // Bungkus GridView dengan ini
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: widthScreen/heightScreen,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color:Colors.redAccent,width: 5),
                shape: BoxShape.circle,
                image:DecorationImage(image: AssetImage('images/icon5.png',),
                scale: 1.5,
                ),
                color: Colors.white,
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                new TextButton(onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => ItemMaster())),style:TextButton.styleFrom(backgroundColor: Colors.redAccent), child:  Text("Item Master",
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
                scale: 1.5, 
                ),
                color: Colors.white,
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                new TextButton(onPressed: (){},style:TextButton.styleFrom(backgroundColor: Colors.redAccent), child:  Text("Purchase Order",
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
                scale: 1.5, 
                
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
      ),
    );
  }

  
}
