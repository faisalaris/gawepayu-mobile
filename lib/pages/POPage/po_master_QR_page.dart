import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter_http_post_request/model/PO/po_master_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class GenQRCode extends StatefulWidget {
  List<PoMasterRequestModel> list;

  GenQRCode({this.list});

  @override
  _GenQRCodeState createState() => _GenQRCodeState();
}

class _GenQRCodeState extends State<GenQRCode> {
  String _qrcode = '';
  
  List<PoMasterRequestModel> _getItemMaster = [];
  
  GlobalKey globalKey = new GlobalKey();

  convertJson(PoMasterRequestModel pomaster){
    _qrcode = jsonEncode(pomaster.toJson());
  }

      @override
    void initState() {
      _getItemMaster.addAll(widget.list);
      PoMasterRequestModel porequest = new PoMasterRequestModel();

      for (int i = 0; i < _getItemMaster.length; i++) {
      porequest.bpCode =_getItemMaster[i].bpCode ;
      porequest.prefix=_getItemMaster[i].prefix;
      porequest.docDate=_getItemMaster[i].docDate;
      porequest.docNum=_getItemMaster[i].docNum;
      porequest.paymentType=_getItemMaster[i].paymentType;
      porequest.posted=_getItemMaster[i].posted;
      porequest.postedDate=_getItemMaster[i].postedDate;
      porequest.poTransDet =_getItemMaster[i].poTransDet;
      }  
      convertJson(porequest);

    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('QR Code Generate'),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.share), onPressed: _captureAndSharePng)
          ]),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: RepaintBoundary(
                          key: globalKey,
                          child: QrImage(
                            data: _qrcode,
                            size: 0.5 * bodyHeight,
                          ))))
            ],
          ),
        ),
      ),
    );
  }

    Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      final channel = const MethodChannel('channel:me.camellabs.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch(e) {
      print(e.toString());
    }
  }
 }
