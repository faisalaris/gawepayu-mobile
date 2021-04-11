import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Login/login_model.dart';
import '../model/GenSet/item_grade_model.dart';
import '../model/GenSet/item_group_model.dart';
import '../model/GenSet/item_satuan_model.dart';
import '../model/Item Master/item_master_model.dart';

const web = '192.168.100.25:3000';
//const web2 = '192.168.100.25:8080';
const web2 = '192.168.1.100:8080';
const apikey = '277f1bbb-f4c6-4ea7-93e7-5a2e2e9b42e4';

class APIServiceLogin {
  Future<LoginRequestModel> getPost(
      String username, String password) async {
      
       Map<String, String> qParams = {
      'username': username,
      'password': password,
    };
    Uri url = new Uri.http(web2,'/api/GenUser/ValidateLogin',qParams);
    final response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    }
    );

    if (response.statusCode == 200) {
      return LoginRequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemGrade {
  Future<List<ItemGradeRequestModel>> getPost() async {
       Map<String, String> qParams = {
      'type': '03',
    }; 

    Uri url = new Uri.http(web2,'/api/GenSet/GetGenSetByType',qParams);
    final response = await http.get(url,
     headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      return itemGradePostFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemGroup {
  Future<List<ItemGroupRequestModel>> getPost() async {
      Map<String, String> qParams = {
      'type': '02',
    };   
    Uri url = new Uri.http(web2,'/api/GenSet/GetGenSetByType',qParams);
    final response = await http.get(url,
        headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      return itemGroupPostFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemSatuan {
  Future<List<ItemSatuanRequestModel>> getPost() async {
      Map<String, String> qParams = {
      'type': '05',
    };   
    Uri url = new Uri.http(web2,'/api/GenSet/GetGenSetByType',qParams);
    final response = await http.get(url,
        headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      return itemSatuanPostFromJson(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemMasterGetAll {
  Future<List<ItemMasterRequestModel>> getPost() async {
       Map<String, String> qParams = {
      //'startrow' :'35000', 
      'limit': '40000',
    };  
    Uri url = new Uri.http(web2,'/api/InvMst/GetInvMst',qParams);
    final response = await http.get(url,
     headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    });
    if (response.statusCode == 200) {
      return itemMasterPostFromJson(response.body);
      //var responseJson = json.decode(response.body);
      //return (responseJson as List)
      //.map((p) =>ItemMasterRequestModel.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemMasterGet {
  Future<ItemMasterRequestModel> getPost( int code) async {
      
   Map<String, dynamic> qParams = {
      'code': code,
    };

    Uri url = new Uri.http(web2,'/api/InvMst/GetInvMasterByCode',qParams);
    print(url);
    final response = await http.get(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    });
    if (response.statusCode == 200) {
      return ItemMasterRequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
}

class APIServiceItemMasterPost {
  Future<ItemMasterPostModel> tojson( ItemMasterPostModel masterpostmodel) async {
    dynamic _postBody = jsonEncode(masterpostmodel.toJson());
    Uri url = new Uri.http(web2,'/api/InvMst/AddInvMst');
    final response = await http.post(url,
     headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    },
    body: _postBody);
    
    if (response.statusCode == 200 ) {
      dynamic _jsonBody = response.body;
      ItemMasterPostModel getResponse = new ItemMasterPostModel();
      getResponse = ItemMasterPostModel.fromJson(jsonDecode(_jsonBody));
      return getResponse ;
    } else {
      throw Exception('Failed to post data!');
    }
  }
}

class APIServiceItemMasterPut {
  Future<ItemMasterPutModel> tojson( ItemMasterPutModel masterputmodel) async {
    dynamic _postBody = jsonEncode(masterputmodel.toJson());
    Uri url = new Uri.http(web2,'/api/InvMst/UpdateInvMst');
    final response = await http.put(url,
     headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    },
    body: _postBody);
    
    if (response.statusCode == 200 ) {
      dynamic _jsonBody = response.body;
      ItemMasterPutModel getResponse = new ItemMasterPutModel();
      getResponse = ItemMasterPutModel.fromJson(jsonDecode(_jsonBody));
      return getResponse ;
    } else {
      throw Exception('Failed to post data!');
    }
  }
}

class APIServicePriceListDelete {
  Future<SpriceList> deleteJson( dynamic id) async {

      Map<String, String> qParams = {
      'id' :id.toString(), 
    };  
    Uri url = new Uri.http(web2,'/api/InvSpriceList/DeletePriceList',qParams);
    final response = await http.delete(url,
     headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
      'ApiKey' : apikey
    },);
    
    if (response.statusCode == 200 ) {
      dynamic _jsonBody = response.body;
      SpriceList getResponse = new SpriceList();
      getResponse = SpriceList.fromJson(jsonDecode(_jsonBody));
      return getResponse ;
    } else {
      throw Exception('Failed to post data!');
    }
  }
}


