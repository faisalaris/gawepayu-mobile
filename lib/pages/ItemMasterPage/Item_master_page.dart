import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/Item Master/item_master_model.dart';
import 'package:flutter_http_post_request/api/api_service.dart';
import './item_master_view_page.dart';
import './item_master_add_page.dart';
import 'package:flutter_http_post_request/ProgressHUD.dart';


class ItemMaster extends StatefulWidget {
  @override
  _ItemMasterState createState() => _ItemMasterState();
}


class _ItemMasterState extends State<ItemMaster> {

  bool isApiCallProcess = false;

  final TextEditingController _filter = new TextEditingController();
  List<ItemMasterRequestModel> _filteredNames = []; // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search);
  String _searchText = '';
  Widget _appBarTitle = new Text( 'Search item (deskripsi)' ,style: TextStyle(color: Colors.white) ,);
  List<ItemMasterRequestModel> _getItemMaster = [];

  _ItemMasterState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _filteredNames = _getItemMaster;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
    @override
    void initState() {
    isApiCallProcess = true;
    APIServiceItemMasterGetAll apiItem = new APIServiceItemMasterGetAll();
    apiItem.getPost().then((value) {
      if(value!= null){
      setState(() {
        _getItemMaster.addAll(value);
        _filteredNames = _getItemMaster ;
        isApiCallProcess = false;
      });
    }});
    super.initState();
    }
  
  void _searchPressed() {
  setState(() {
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        controller: _filter,
        decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search),
          hintText: 'Search...'
        ),
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text('Search Item (Deskirpsi)',style: TextStyle(color: Colors.white));
       _filteredNames =_getItemMaster;
      _filter.clear();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _masterPage(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3, 
    );
  }
  
  Widget _masterPage(BuildContext context) {

    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color:Colors.white,),
        backgroundColor: Colors.redAccent,
        onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => ItemAddMaster())),
      ),
        appBar: AppBar(
          title: _appBarTitle,
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          leading: new IconButton
          (icon: _searchIcon, 
          onPressed: _searchPressed,
        )
        ),
        body: _buildList(),
              
        );
  }


  Widget _buildList() {
    if ((_searchText.isNotEmpty)) {
      List<ItemMasterRequestModel> tempList = [];
      for (int i = 0; i < _filteredNames.length; i++) {
        if (_filteredNames[i].description.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(_filteredNames[i]);
        }
      }
      _filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: _getItemMaster == null ? 0 : _filteredNames.length,
      itemBuilder: (BuildContext context, index) {
        return new Container(
          height: 100,    
          child :Card(
            child : InkWell(
              onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => ItemMasterView(list:_filteredNames,index: index,))),
              child: Column(children: [
            ListTile(
              leading: Icon(Icons.desktop_windows,size: 30,),
              title: Text(_filteredNames[index].code.toString() +
                  '-' +
                  _filteredNames[index].description,style: new TextStyle(fontSize: 30,color: Colors.redAccent),),
            ),
          ])
          )
          )
          );
        },
        );
        
  }
}

