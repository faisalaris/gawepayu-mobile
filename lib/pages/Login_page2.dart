import 'package:flutter_http_post_request/model/Login/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

class LoginApi extends StatefulWidget {
  @override
  _LoginPageState2 createState () => new _LoginPageState2() ;
}

class _LoginPageState2 extends State<LoginApi> {

  String _link = '192.168.100.25:8080' ;
  String _login = '192.168.100.25:3000';

  String _username ='tyo';
  String _password ='123456';
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  Future<LoginRequestModel> login  (String user, dynamic password) async  {
    

     Map<String, dynamic> qParams = {
      'username': user,
      'password': password,
    };
    
    var response = await http.post(
    //Uri.https('https://localhost:44391','/api/GenUser/ValidateLogin',qParams),
    Uri.http(_link,'/api/GenUser/ValidateLogin',qParams),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : '277f1bbb-f4c6-4ea7-93e7-5a2e2e9b42e4'
    }
  );

  if (response.statusCode == 200 || response.statusCode == 400){
    return LoginRequestModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed connect to API.');
  }
}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name Here'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Form(
          key: globalFormKey,
          child: new Center(
          child: new Column(
            children: <Widget>[
              TextFormField(
                decoration : InputDecoration(
                  labelText: 'username',
                  hintText : 'please input username'
                ),
                onSaved:(input) => _username = input ,
                validator: (input){
                               if (input == null) {
                                 return 'username harus di input';
                               }
                               return null ;
                             },
              ),
              TextFormField(
                decoration : InputDecoration(
                  labelText: 'password',
                  hintText : 'please input password',
                ),
                onSaved:(input) => _password = input ,
                validator: (input){
                               if (input == null) {
                                 return 'password harus di input';
                               }
                               return null ;
                             },
                obscureText: true,
              ),
              TextButton(onPressed:(){
                login(_username, _password);
              },child: new Text("Login"))
            ],
          ),
          ),
        ),
      ),
    ) ;
  }

}

