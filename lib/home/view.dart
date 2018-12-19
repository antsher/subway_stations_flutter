import 'package:flutter/material.dart';
import 'package:subway_stations/home/model.dart' as model;

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final _textFocus = FocusNode();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
      child: ListView(
        children: <Widget>[
          TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                labelText: 'Email',
              ),
              onSubmitted: (String value) {
                FocusScope.of(context).requestFocus(_textFocus);
              }),
          TextField(
            controller: _passwordController,
            focusNode: _textFocus,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              labelText: 'Text',
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('SIGN UP'),
                  onPressed: () {
                    model.signUpWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                  },
                ),
                RaisedButton(
                  child: Text('SIGN IN'),
                  onPressed: () {
                    model.signInWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
