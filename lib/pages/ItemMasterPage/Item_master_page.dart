import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/Item Master/item_master_model.dart';
import 'package:flutter_http_post_request/api/api_service.dart';
import 'package:flutter_http_post_request/pages/HomePage/home_page.dart';
import './item_master_view_page.dart';
import './item_master_add_page.dart';
import 'package:flutter_http_post_request/ProgressHUD.dart';
import './item_master_scan_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class ItemMaster extends StatefulWidget {
  String deadstock ;

  ItemMaster({this.deadstock});

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
    apiItem.getPost(widget.deadstock).then((value) {
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

void _reloadPressed() {
    setState(() {
    isApiCallProcess = true;
    _getItemMaster = [];
    _filteredNames =[];
    APIServiceItemMasterGetAll apiItem = new APIServiceItemMasterGetAll();
    apiItem.getPost(widget.deadstock).then((value) {
      if(value!= null){
      setState(() {
        _getItemMaster.addAll(value);
        _filteredNames = _getItemMaster ;
        isApiCallProcess = false;
      });
    }});
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
      floatingActionButton: buildSpeedDial(), 
        appBar: AppBar(
          title: _appBarTitle,
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          leading: new IconButton
          (icon: _searchIcon, 
          onPressed: _searchPressed,
        ),
        actions: [
          IconButton(icon: Icon(Icons.refresh), 
          onPressed: _reloadPressed),
          IconButton(icon: Icon(Icons.home), 
          onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()))),
        ]
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

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      /// both default to 16
      marginEnd: 18,
      marginBottom: 20,
      icon: Icons.add,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.white,
      foregroundColor: Colors.redAccent,
      elevation: 8.0,
      shape: CircleBorder(),

      // orientation: SpeedDialOrientation.Up,
      // childMarginBottom: 2,
      // childMarginTop: 2,
      gradientBoxShape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black, Colors.white],
      ),
      children: [
        SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          label: 'Add Item',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => ItemAddMaster())),
        ),
        SpeedDialChild(
          child: Icon(Icons.scanner),
          backgroundColor: Colors.blue,
          label: 'Scan barcode',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => ScanBarcode(list:_getItemMaster))),
        ),
      ],
    );
  }

}

