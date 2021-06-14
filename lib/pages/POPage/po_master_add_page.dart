import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/PO/po_master_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_http_post_request/api/api_service.dart';
import './po_master_page.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';


class PayMentModel {
  String code;
  String desc;

  PayMentModel({this.code, this.desc});

   @override
  String toString() {
    return desc;
  }
}

get_list(){
  List<PayMentModel> datas = [
    PayMentModel(code: "1", desc: "Cash"),
    PayMentModel(code: "2", desc: "Credit"),
  ];
  return datas;
}

class POAddMaster extends StatefulWidget {
  @override
  _POAddMasterState createState() => _POAddMasterState();
}

class _POAddMasterState extends State<POAddMaster> {
  var formKey = GlobalKey<FormState>();
  var bpCode = TextEditingController();
  var docdate = TextEditingController();
  var postedDate = TextEditingController();
  var posted = TextEditingController();
  var paymentType = TextEditingController();

  String _date = DateTime.now().toIso8601String();

  List _paylist = get_list();
   PayMentModel _selectedValue = PayMentModel(code: "0", desc: "value");

  BusinessPPO _valBpMaster = new BusinessPPO();
  
  List<BusinessPPO> _listBpMaster = [];
  PoMasterRequestModel _listPomaster = new PoMasterRequestModel();
  PoMasterPostModel poMaster = new PoMasterPostModel();
  DateTime selectedDate = DateTime.now();
 


  _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2090),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
    });
}

  Future _alertSave(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Info"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PoMaster()));
                    },
                    child: Text("Ok"))
              ]);
        });
  }

  Future _alertFailed(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Info"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ]);
        });
  }

  void _onsaved(
      String bpCode,
      dynamic docdate,
      dynamic paymentType,
     ) {
    setState(() {
      poMaster.prefix="";
      poMaster.bpCode = bpCode;
      poMaster.docDate = docdate;
      poMaster.postedDate = _date;
      poMaster.posted = "0";
      poMaster.paymentType = paymentType;
     

      APIServicePoMasterPost apiItemPost = new APIServicePoMasterPost();
      apiItemPost.tojson(poMaster);
    });
  }

  @override
  void initState() {
    super.initState();
    APIServiceBusinessP apiBusinessP = new APIServiceBusinessP();
    apiBusinessP.getPost().then((value) {
      setState(() {
        _listBpMaster.addAll(value);
        _valBpMaster = _listBpMaster[0];
      });
    });

   
    //getgroup();
    //getgrade();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Add PO Transaction",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              //Expanded(
              //child:
              //TextFormField(
              //controller : code,
              // decoration : InputDecoration(
              //labelText: 'Code',
              // hintText: 'input Code'
              // ),
              //validator: (value){
              //if (value == null) {
              //return 'Code harus di input';
              //}
              //return null ;
              //},
              //onSaved : (value) => code.text = value
              //)
              //),
              Expanded(
                  child: Column(
                    children: <Widget>[
                      SearchableDropdown<BusinessPPO>(
                        isExpanded: true,
                        label: Text('Supplier'),
                        items: _listBpMaster
                              .map((data) => DropdownMenuItem<BusinessPPO>(
                                child: Text(data.desc),
                                value: data,
                              )).toList(),
                      onChanged: (BusinessPPO value) {
                          setState(() {
                            _valBpMaster = value;
                          });
                        },
                         hint: Text('Select Supplier'),
                          ),
                TextFormField(
                      controller: docdate,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Document date',
                          hintText: 'update Docdate'),
                      onTap: (){
                      docdate.text=_selectDate(context).toIso8601String();},
                      ),
                  SearchableDropdown<PayMentModel>(
                        isExpanded : true,
                        label: Text('Payment Type'),
                        items: _paylist
                              .map((data) => DropdownMenuItem<PayMentModel>(
                                child: Text(data.desc),
                                value: data,
                              )).toList(),
                      onChanged: (PayMentModel value) {
                          setState(() => _selectedValue = value);
                        },
                         hint: Text('Select Payment Type'),
                          ),
                    ]
                  )),
          Expanded(
                  child: Container(
                      padding: new EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[   
                               ButtonTheme(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  child: TextButton(
                                    onPressed: () {
                                      if (docdate.text == "") {
                                        _alertFailed(
                                            context, "Docdate is mandatory");
                                        }
                                        _onsaved(
                                            _valBpMaster.code,
                                            selectedDate.toIso8601String(),
                                            _selectedValue.code,
                                            );

                                        _alertSave(context, "Save Successfuly");
                                      },
                                    
                                    child: Text('Save',
                                        style: TextStyle(color: Colors.white)),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => Colors.redAccent)),
                                  ))
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
