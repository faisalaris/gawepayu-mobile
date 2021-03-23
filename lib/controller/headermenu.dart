import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import 'package:path/path.dart';

class HeaderMenu{
  static const String Home ='Home';
  static const String Logout ='Logout';

  static const List<String> listmenu = <String>[
    Home,
    Logout
  ];

}

Widget actionHeadMenu (String menuname){

  return AppBar(
    title: Text(
          menuname,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return HeaderMenu.listmenu.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                  );
              }).toList();
            }
          )
          ],
  );
}



void choiceAction (String choice){
    if (choice == HeaderMenu.Logout) {

    } else {
    }
  }
 