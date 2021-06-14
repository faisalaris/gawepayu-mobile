import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/PO/po_master_model.dart';
import 'package:flutter_http_post_request/api/api_service.dart';
import 'package:flutter_http_post_request/widget/text_dialog_widget.dart';
import 'package:flutter_http_post_request/pages/POPage/po_master_page.dart';
import 'package:flutter_http_post_request/model/Item Master/item_master_model.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter_http_post_request/ProgressHUD.dart';


class Utils {
  static List<T> modelBuilder<M, T>(
          List<M> models, T Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, T>((index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}

class Posted {
  String code;
  String desc;

  Posted({this.code, this.desc});

   @override
  String toString() {
    return desc;
  }
}

get_list(){
  List<Posted> datas = [
    Posted(code: "0", desc: "No"),
    Posted(code: "1", desc: "Yes"),
  ];
  return datas;
}

class PayMentModel {
  String code;
  String desc;

  PayMentModel({this.code, this.desc});

   @override
  String toString() {
    return desc;
  }
}

get_listpay(){
  List<PayMentModel> datas = [
    PayMentModel(code: "1", desc: "Cash"),
    PayMentModel(code: "2", desc: "Credit"),
  ];
  return datas;
}

class POEditMaster extends StatefulWidget {
  List<PoMasterRequestModel> list;
  List<ItemMasterRequestModel>item;
  POEditMaster({this.list,this.item});

  @override
  _POEditMasterState createState() => _POEditMasterState();
}

class _POEditMasterState extends State<POEditMaster>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  bool isApiCallProcess = false;

  List<PoMasterRequestModel> _pomaster = [];
  

  List<PoTransDetail> _pOTrans = [];
  List<PoTransDetail> _oldpOTrans = [];
  List<PoTransDetailPut> _updatepOTrans = [];
  List<PoTransDetailPut> _deletepOTrans = [];
  List<PoTransDetail> _addPrice = [];

 List<ItemMasterRequestModel> _getItemMaster = [];
  
  List<BusinessPPO> _listBpMaster = [];


  String _docdate;
  String _posteddate;


   List _postedlist = get_list();
   Posted _selectedValue = Posted(code: "init", desc: "Initial");

     List _paylist = get_listpay();
   PayMentModel _selectedValuepay = PayMentModel(code: "init", desc: "initial");

  // master item controller
  var bpCode = TextEditingController();
  var docdate = TextEditingController();
  var postedDate = TextEditingController();
  var posted = TextEditingController();
  var paymentType = TextEditingController();
  

String _date = DateTime.now().toIso8601String();

  // Price list Controller
var _addSpriceQty = TextEditingController(text: "0");
var _addSpricePrice = TextEditingController(text: "0");
var _dis1 = TextEditingController(text: "0");
var _ppn = TextEditingController(text: "0");
 

  BusinessPPO _valBpMaster = new BusinessPPO();
  ItemMasterRequestModel _valItemMaster = new ItemMasterRequestModel();
  DateTime selectedDatedoc ;
  DateTime selectedDatedpos ;
  DateTime _selectedDatedoc ;

  dateDoc(){
    selectedDatedoc = DateTime.parse(_pomaster[0].docDate);
    _selectedDatedoc = selectedDatedoc;
  }


  @override
  void initState() {
    
    _controller = new TabController(length: 2, vsync: this);
    _pomaster.add(widget.list[0]);
    _pOTrans.addAll(_pomaster[0].poTransDet);
    _oldpOTrans = _pOTrans;
    _getItemMaster.addAll(widget.item);
    dateDoc();
    
    PoTransDetailPut _potransput = new PoTransDetailPut();
    for (int i = 0; i < _pOTrans.length; i++) {
      _potransput.code = _pOTrans[i].code;
      _potransput.docNum = _pOTrans[i].docNum;
      _potransput.itemCode = _pOTrans[i].itemCode[0].code.toString();
      _potransput.qty = _pOTrans[i].qty;
      _potransput.price = _pOTrans[i].price;
      _potransput.satuan = _pOTrans[i].satuan;
      _potransput.qtySatuan = _pOTrans[i].qtySatuan;  
      _potransput.totalPrice = _pOTrans[i].totalPrice;
      _potransput.updateOpeningBalace = _pOTrans[i].updateOpeningBalace;
      _potransput.disc1 = _pOTrans[i].disc1;
      _potransput.disc2 = _pOTrans[i].disc2;
      _potransput.disc3 = _pOTrans[i].disc3;
      _potransput.disc4 = _pOTrans[i].disc4;
      _potransput.totalDisc = _pOTrans[i].totalDisc;
      _potransput.diff = _pOTrans[i].diff;
      _potransput.ppn = _pOTrans[i].ppn;

       _updatepOTrans.add(_potransput);            
    }



   APIServiceBusinessP apiBusinessP = new APIServiceBusinessP();
    apiBusinessP.getPost().then((value) {
      setState(() {
        _listBpMaster.addAll(value);
        _valBpMaster = widget.list[0].bpCode[0];
      });
    });
    super.initState();
  }
refreshList() {
    setState(() {
      _updatepOTrans = _updatepOTrans;
      isApiCallProcess = false;
    });
  }

  _addDialog(BuildContext context)async{
    return showDialog(
      context :context,
      builder: (context){
      return AlertDialog(
       title: Text("Add Item"),
       content:
       SizedBox( height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
       child :
       Column(
       children: <Widget>[
       SearchableDropdown<ItemMasterRequestModel>(
                        isExpanded: true,
                        label: Text('Item'),
                        items: _getItemMaster
                              .map((data) => DropdownMenuItem<ItemMasterRequestModel>(
                                child: Text(data.description),
                                value: data,
                              )).toList(),
                      onChanged: (ItemMasterRequestModel value) {
                          setState(() {
                            _valItemMaster = value;
                          });
                        },
                         hint: Text('Select item'),
                          ),    
       TextFormField(
          controller: _addSpriceQty,
          decoration: InputDecoration(
            labelText: 'Quantity',
            border: OutlineInputBorder(),
          ),
          onSaved: (value) => _addSpriceQty.text = value  
      ),
      Divider(height:10 ),
      TextFormField(
          controller: _addSpricePrice,
          decoration: InputDecoration(
            labelText: 'Price',
            border: OutlineInputBorder(),
          ),  
      ),
        TextFormField(
          controller: _dis1,
          decoration: InputDecoration(
            labelText: 'Diskon 1',
            border: OutlineInputBorder(),
          ),  
      ),
       TextFormField(
          controller: _ppn,
          decoration: InputDecoration(
            labelText: 'ppn',
            border: OutlineInputBorder(),
          ),  
      ),
       ])),
       actions: [
         ElevatedButton(
           child: Text('Add'),
           onPressed: (){
           double _totaldisc = (double.parse(_dis1.text) /100)* (int.parse(_addSpricePrice.text) *int.parse(_addSpriceQty.text));
           double _totalprice = double.parse(_addSpriceQty.text)* int.parse(_addSpricePrice.text)  ;  
           PoTransDetailPut _addpricelist = new PoTransDetailPut();
           _addpricelist.itemCode=_valItemMaster.code.toString();
           _addpricelist.docNum = _pomaster[0].docNum;
           _addpricelist.price = int.parse(_addSpricePrice.text);
           _addpricelist.qty =   int.parse(_addSpriceQty.text);
           _addpricelist.ppn = int.parse(_ppn.text);
           _addpricelist.disc1 = _dis1.text;
           _addpricelist.totalDisc = _totaldisc.toString();
           _addpricelist.totalPrice = _totalprice + (_totalprice - _totaldisc)* (int.parse(_ppn.text)/100) ;

           _updatepOTrans.add(_addpricelist);
           refreshList();
           Navigator.pop(context);

           })
       ],
       );
      }
    );
  }

  _selectDateDoc(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDatedoc, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2090),
  );
  if (picked != null && picked != selectedDatedoc)
    setState(() {
      selectedDatedoc = picked;
    });
}


  @override
    Widget build(BuildContext context) {
    return ProgressHUD(
      child: _bodybuild(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3, 
    );
  }


  Widget _bodybuild(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title:
                Text('PO Item master', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.redAccent,
            bottom: new TabBar(
              controller: _controller,
              tabs: [
                new Tab(
                  icon: const Icon(Icons.receipt),    
                ),
                new Tab(
                  icon: const Icon(Icons.receipt),
                  text: 'PO Price List',
                ),
              ],
            )),
        body: new TabBarView(controller: _controller, children: <Widget>[
          new SingleChildScrollView(
              child: new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Form(
              child: new Column(
                children: <Widget>[
                                SearchableDropdown<BusinessPPO>(
                        isExpanded: true,
                        label: Text('Supplier :${widget.list[0].bpCode[0].desc}'),
                        items: _listBpMaster
                              .map((data) => DropdownMenuItem<BusinessPPO>(
                                child: Text(data.desc),
                                value: _valBpMaster,
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
                          labelText: 'Doc date : ${widget.list[0].docDate}',
                          hintText: 'update Docdate'),
                      onTap: (){
                       _docdate= _selectDateDoc(context).toIso8601String();}
                      ),
                  SearchableDropdown<Posted>(
                        isExpanded : true,
                        label: Text('Posted'),
                        items: _postedlist
                              .map((data) => DropdownMenuItem<Posted>(
                                child: Text(data.desc),
                                value: data,
                              )).toList(),
                      onChanged: (Posted value) {
                          setState(() => _selectedValue = value);
                        },
                         hint: Text('Select Posted Type'),
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
                          setState(() => _selectedValuepay = value);
                        },
                         hint: Text('Select Payment Type'),
                          ),
                  
                ],
              ),
            ),
          )),
          new SingleChildScrollView(
              child:   new Container(
                  padding: new EdgeInsets.all(32.0),
                  child: new Form(
                      child: new Column(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.add), onPressed: () {
                            _addDialog(context);
                          }),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                DataTable(columns: [
                                  DataColumn(label: Text("")),
                                  DataColumn(label: Text("Item")),
                                  DataColumn(label: Text("Quantity")),
                                  DataColumn(label: Text("Harga")),
                                  DataColumn(label: Text("Diskon")),
                                  DataColumn(label: Text("ppn")),
                                ], rows: getRows(context, _updatepOTrans)),
                                ButtonTheme(
                                    minWidth: 200.0,
                                    height: 100.0,
                                    child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text("INFO"),
                                                    content: Text(
                                                        "Tombol ini akan memproses data edit, delete dan add yang sudah dilakukan"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            isApiCallProcess = true;
                                                             PoMasterPutModel _updatePomaster = new PoMasterPutModel();
                                                             _updatePomaster.prefix = "";
                                                             _updatePomaster.docNum = _pomaster[0].docNum;
                                                              _updatePomaster.bpCode = _valBpMaster.code;

                                                             if(_selectedDatedoc == selectedDatedoc ){
                                                               _updatePomaster.docDate = _selectedDatedoc.toIso8601String();
                                                             }
                                                             else {
                                                               _updatePomaster.docDate = selectedDatedoc.toIso8601String();
                                                             }
                                                            
                                                             if (_selectedValue.code == "1"){
                                                                _updatePomaster.postedDate = _date ;
                                                             }
                                                             else {
                                                               _updatePomaster.postedDate = _selectedDatedoc.toIso8601String() ;
                                                             }
                                                             if(_selectedValue.code == "init"){
                                                               _updatePomaster.posted = _pomaster[0].posted;
                                                             }
                                                             else {
                                                               _updatePomaster.posted = _selectedValue.code;
                                                             }

                                                            if(_selectedValuepay.code == "init"){
                                                               _updatePomaster.paymentType = _pomaster[0].paymentType;
                                                             }
                                                             else {
                                                               _updatePomaster.posted = _selectedValue.code;
                                                             }
  
                                                              _updatePomaster.poTransDet =[];

                                                              for (int i = 0; i < _updatepOTrans.length; i++) {
                                                                   int _disc = int.parse(_updatepOTrans[i].disc1);
                                                                   int _qty = _updatepOTrans[i].qty;
                                                                   int _price = _updatepOTrans[i].price;
                                                                   double _totaldisc = (_disc /100)* (_qty * _price);
                                                                   int _ppn = _updatepOTrans[i].ppn;
                                                                   //double.parse(_updatepOTrans[i].ppn);

                                                                   int _totalprice =(_qty * _price);
                                                                  
                                                                  _updatepOTrans[i].totalDisc = _totaldisc.toString();
                                                                  _updatepOTrans[i].totalPrice = _totalprice + (_totalprice - _totaldisc)* (_ppn/100) ;

                                                              }

                                                              _updatePomaster.poTransDet.addAll(_updatepOTrans);


                                                              //  APIServicePoMasterPut apiput = new APIServicePoMasterPut();
                                                              //  apiput.tojson(_updatePomaster);

                                                                if (_deletepOTrans.length > 0) {
                                                                    for (int i = 0; i < _deletepOTrans.length; i++) {
                                                                    APIServicePoListDelete apidelete = new APIServicePoListDelete();
                                                                    apidelete.deleteJson(_deletepOTrans[i].code);
                                                                    }
                                                                }
                                                                                                                            
                                                               isApiCallProcess = false; 
                                                             Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => PoMaster()));
                                                          },
                                                          child: Text(
                                                              "Lanjutkan Proses")),
                                                      TextButton(
                                                          onPressed: () {
                                                             Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Kembali"))
                                                    ]);
                                              });
                                        },
                                        child: Text('Proses',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) =>
                                                        Colors.red))))
                              ])
                        ])
                  ])))),
        ]));
  }

  List<DataRow> getRows(BuildContext context, List<PoTransDetailPut> _potrans) =>
      _potrans.map((PoTransDetailPut pOTrans) {
        //final cells = ["Hapus", pOTrans.itemCode,pOTrans.qty];
        final cells = ["Hapus", pOTrans.itemCode,pOTrans.qty, pOTrans.price,pOTrans.disc1,pOTrans.ppn];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            //final showEditIcon = index == 1|| index == 2 ;
            final showEditIcon = index == 1 || index == 2 || index == 3 || index == 4 || index == 5 ;
            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                switch (index) {
                  case 0:
                    for (int i = 0; i < _potrans.length; i++) {
                      if (_potrans.elementAt(i).code == pOTrans.code) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text("Hapus Data"),
                                  content: Text("Yakin akan di hapus"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _deletepOTrans
                                              .add(_potrans.elementAt(i));
                                          _potrans.removeAt(i);
                                          refreshList();
                                        },
                                        child: Text("Ok")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"))
                                  ]);
                            });
                      }
                    }

                    break;
                   case 1:
                    editItem(pOTrans);
                    break;  
                  case 2:
                    editQty(pOTrans);
                    break;
                  case 3:
                    editPrice(pOTrans);
                    break;
                  case 4:
                    editDisc(pOTrans);
                    break;
                  case 5:
                    editPpn(pOTrans);
                    break;      
                  //case 3 :
                   // updateStatusPrice(sPrice);
                   // break;
                }
              },
            );
          }),
        );
      }).toList();

  Future editQty(PoTransDetailPut editQty) async {
    final qty = await showTextDialog(
      context,
      title: 'Change Quantity',
      value: editQty.qty.toString(),
    );
    final id = editQty.code;
    final code = editQty.docNum;

    setState(() => _updatepOTrans = _updatepOTrans.map((editqty) {
          final isEditedqty = editqty == editQty;

          return isEditedqty ? editqty.copy(code: id,docNum: code,qty: double.parse(qty)) : editqty;
        }).toList());
  }


  Future editPrice(PoTransDetailPut editPrice) async {
    final price = await showTextDialog(
      context,
      title: 'Change Price',
      value: editPrice.price.toString(),
    );

    setState(() => _updatepOTrans = _updatepOTrans .map((editprice) {
          final isEditedprice = editprice == editPrice;

          return isEditedprice ? editprice.copy(price: double.parse(price)) : editprice;
        }).toList());
  }

  Future editDisc(PoTransDetailPut editDisc) async {
    final disc = await showTextDialog(
      context,
      title: 'Change disc',
      value: editDisc.disc1.toString(),
    );

    setState(() => _updatepOTrans = _updatepOTrans .map((editDisc) {
          final isEditeddisc = editDisc == editDisc;

          return isEditeddisc ? editDisc.copy(disc1: disc.toString()) : editDisc;
        }).toList());
  }

  Future editPpn(PoTransDetailPut editPpn) async {
    final ppn = await showTextDialog(
      context,
      title: 'Change disc',
      value: editPpn.ppn.toString(),
    );

    setState(() => _updatepOTrans = _updatepOTrans .map((editPpn) {
          final isEditedppn = editPpn == editPpn;

          return isEditedppn ? editPpn.copy(ppn: double.parse(ppn)) : editPpn;
        }).toList());
  }

   Future editItem(PoTransDetailPut editItem) async {
    final item = await showTextDialogItem(
      context,
      title: 'Change Item',
      value: editItem.itemCode.toString(),
      itemMaster : _getItemMaster
    );

    setState(() => _updatepOTrans = _updatepOTrans .map((editItem) {
          final isEditedItem = editItem == editItem;

          return isEditedItem ? editItem.copy(itemCode: item.toString()) : editItem;
        }).toList());
  }
}


