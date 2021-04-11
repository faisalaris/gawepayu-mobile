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

List<LoginRequestModel> postListFromJson(String str) => List<LoginRequestModel>.from(json.decode(str).map((x) => LoginRequestModel.fromJson(x)));
//LoginRequestModel postFromJson(String str) => LoginRequestModel.from(json.decode(str).map((x) => LoginRequestModel.fromJson(x)));


class LoginRequestModel {
  String userId;
  String authorization;
  dynamic status;
  String statusMessage;

  LoginRequestModel({
    this.userId,
    this.authorization,
    this.status,
    this.statusMessage
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
        userId: json["userId"],
        authorization: json["authorization"],
        status : json["status"],
        statusMessage : json["statusMessage"],
    );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'userId': userId,
      'authorization': authorization,
      'status' : status,
      'statusMessage' : statusMessage,
    };

    return map;
  }

}
