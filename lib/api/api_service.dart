import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';
import '../model/item_grade_model.dart';
import '../model/item_group_model.dart';
import '../model/item_master_model.dart';

const web = '192.168.1.5:3000';


class APIServiceLogin {
  Future<List<LoginRequestModel>> getPost(
      String username, String password) async {
      
       Map<String, String> qParams = {
      'username': username,
      'password': password,
    };
    Uri url = new Uri.http(web,'/login',qParams);
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 400) {
      return postFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemGrade {
  Future<List<ItemGradeRequestModel>> getPost() async {
      
    Uri url = new Uri.http(web,'/itemgrade');
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 400) {
      return itemGradePostFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemGroup {
  Future<List<ItemGroupRequestModel>> getPost() async {
      
    Uri url = new Uri.http(web,'/itemgroup');
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 400) {
      return itemGroupPostFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemMasterGetAll {
  Future<List<ItemMasterRequestModel>> getPost() async {
      
    Uri url = new Uri.http(web,'/item');
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 400) {
      return itemMasterPostFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemMasterGet {
  Future<List<ItemMasterRequestModel>> getPost( String description) async {
      
   Map<String, String> qParams = {
      'description': description,
    };

    Uri url = new Uri.http(web,'/item',qParams);
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 400) {
      return itemMasterPostFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemMasterPost {
  Future<List<ItemMasterRequestModel>> tojson( ItemMasterRequestModel masterrequestmodel) async {
    Uri url = new Uri.http(web,'/item');
    final response = await http.post(url,body: masterrequestmodel.toJson());
    
    if (response.statusCode == 200 || response.statusCode == 400) {
      return itemMasterPostFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}


