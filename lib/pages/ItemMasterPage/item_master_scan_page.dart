import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_http_post_request/model/Item Master/item_master_model.dart';
import 'item_master_viewfromadd_page.dart';

class ScanBarcode extends StatefulWidget {
  List<ItemMasterRequestModel> list;

  ScanBarcode({this.list});

  @override
  _ScanBarcodeState createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  String _qrcode = '';
  String _getQrcode = '';
  String _barcode = '';
  String _getBarcode = '';
  List<ItemMasterRequestModel> _getItemMaster = [];
  List<ItemMasterRequestModel> _filteredNames = [];

    @override
    void initState() {
     super.initState();
    _getItemMaster.addAll(widget.list);

    }
  Future scanbarcode() async {
    await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)
        .then((String _barcode){
       /*   List<ItemMasterRequestModel> tempList = [];
                   for (int i = 0; i < _getItemMaster.length; i++) {
                   if (_getItemMaster.elementAt(i).barcode == _barcode){
                      tempList.add(_getItemMaster.elementAt(i));
                   }

                   }
                    _filteredNames = tempList ; */
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ItemMasterViewadd2(list: _getItemMaster,barcode: _barcode)));
        } );

  }

  Future scanqrcode() async {
   _getQrcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
      setState(() {
        _qrcode = _getQrcode ;
      });

  }

    Future scanbarcode2() async {
   _getBarcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
      setState(() {
        _barcode = _getBarcode ;
      });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Barcode Scan'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              TextButton(
                onPressed: () {
                  scanbarcode();
                },    
                child: Text(
                  "Scan Barcode",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.redAccent)),
              ),
              Text(_barcode),
                TextButton(
                onPressed: () {
                  scanqrcode();
                },    
                child: Text(
                  "Scan QR Code",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.redAccent)),
              ),
              Text(_qrcode)
            ],
          ),
        ),
      ),
    );
  }
}
