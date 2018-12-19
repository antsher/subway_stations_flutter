import 'package:flutter/material.dart';
import 'package:subway_stations/home/entities.dart';
import 'package:subway_stations/home/model.dart' as model;

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _textFocus = FocusNode();
    final _nameController = TextEditingController();
    final _textController = TextEditingController();
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
      child: ListView(
        children: <Widget>[
          TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Name',
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_textFocus);
              }),
          TextField(
            controller: _textController,
            focusNode: _textFocus,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Text',
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: RaisedButton(
                child: Text('SEND'),
                onPressed: () {
                  model.sendMessage(
                      Message(_nameController.text, _textController.text));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
