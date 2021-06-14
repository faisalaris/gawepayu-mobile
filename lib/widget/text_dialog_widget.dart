import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/api/api_service.dart';
import 'package:flutter_http_post_request/model/Item Master/item_master_model.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';


Future<T> showTextDialog<T>(
  BuildContext context, {
 String title,
 String value,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidget(
        title: title,
        value: value,
      ),
    );

class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;

  const TextDialogWidget({
    Key key,
    this.title,
    this.value,
  }) : super(key: key);

  @override
  _TextDialogWidgetState createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(controller.text),
          )
        ],
      );
}


Future<T> showTextDialogItem<T>(
BuildContext context, {
 String title,
 String value,
 List <ItemMasterRequestModel> itemMaster,
}) =>
    showDialog<T>(
      context: context,
      builder: (context) => TextDialogWidgetItem(
        title: title,
        value: value,
        itemMaster : itemMaster
      ),
    ); 



class TextDialogWidgetItem extends StatefulWidget {
  final String title;
  final String value;
  final List<ItemMasterRequestModel> itemMaster;



  const TextDialogWidgetItem({
    Key key,
    this.title,
    this.value,
    this.itemMaster
  }) : super(key: key);

  @override
  _TextDialogWidgetStateItem createState() => _TextDialogWidgetStateItem();
}

class _TextDialogWidgetStateItem extends State<TextDialogWidgetItem> {
  TextEditingController controller;

   ItemMasterRequestModel newItem = new ItemMasterRequestModel();

  @override
  void initState() {
    super.initState();

    // APIServiceItemMasterGetAll apiItem = new APIServiceItemMasterGetAll();
    // apiItem.getPost("0").then((value) {
    //   if(value!= null){
    //   setState(() {
    //     _getItemMaster.addAll(value);
    //   });
    // }});

    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.title),
        content: 
          SearchableDropdown<ItemMasterRequestModel>(
                        isExpanded: true,
                        label: Text('Item'),
                        items: widget.itemMaster
                              .map((data) => DropdownMenuItem<ItemMasterRequestModel>(
                                child: Text(data.description),
                                value: data,
                              )).toList(),
                      onChanged: (ItemMasterRequestModel value) {
                          setState(() {
                            newItem = value;
                          });
                        },
                         hint: Text('Select Item'),
                          ),
        actions: [
          ElevatedButton(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(newItem.code),
          )
        ],
      );
}