import 'dart:convert';

class LoginResponseModel {
  final String token;
  final String error;

  LoginResponseModel({this.token, this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

List<LoginRequestModel> postFromJson(String str) => List<LoginRequestModel>.from(json.decode(str).map((x) => LoginRequestModel.fromJson(x)));

class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
        username: json["username"],
        password: json["pasword"]
    );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
