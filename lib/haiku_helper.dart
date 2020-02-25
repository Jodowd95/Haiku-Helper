import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poetry_helper/utils/sharebutton.dart';
import 'utils/launch_pad.dart';
import 'utils/syllable_validator.dart';

class HaikuHelper extends StatefulWidget {
  @override
  _HaikuHelperState createState() => _HaikuHelperState();
}

class _HaikuHelperState extends State<HaikuHelper> {
  final lineController1 = TextEditingController();
  final lineController2 = TextEditingController();
  final lineController3 = TextEditingController();
  String line1;
  String line2;
  String line3;
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    lineController1.dispose();
    lineController2.dispose();
    lineController3.dispose();

    super.dispose();
  }

  checkLine1Syllables() {
    if (syllables(lineController1.text) != 5) {
      return _formKey.currentState.deactivate();
    }
  }

  checkLine2Syllables() {
    if (syllables(lineController2.text) != 7) {
      return _formKey.currentState.deactivate();
    }
  }

  checkLine3Syllables() {
    if (syllables(lineController3.text) != 5) {
      return _formKey.currentState.deactivate();
    }
  }
//add padding around inputs
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          title: Text('HaikuHelper'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.all(1.0),
                child: RaisedButton.icon(
                    onPressed: () => haikuTutorial(context),
                    icon: Icon(Icons.help),
                    label: Text('Help')))
          ],
        ),
        body: Builder(
          builder: (context) => Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Center(
              child: ListView(
                shrinkWrap: true,
               // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //title
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Type your Haiku below",
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  //first line
                  Padding(
                    padding: const EdgeInsets.only(left:5.0,right: 5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (val){
                        line1 = lineController1.text;
                      },
                      controller: lineController1,
                      validator: (String value) {
                        value = value.trim();
                       return syllableValidator(value, 5);
                      },
                      decoration: InputDecoration(
                        hintText: " Enter 5 syllables",
                      ),
                    ),
                  ),
                  //second line
                  Padding(
                    padding: const EdgeInsets.only(left:5.0,right: 5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: lineController2,
                      onSaved: (val){
                        line2 = lineController2.text;
                      },
                      validator: (String value) {
                        value = value.trim();
                        return syllableValidator(value, 7);
                      },
                      decoration: InputDecoration(
                        hintText: " Enter 7 syllables",
                      ),
                    ),
                  ),
                  //3rd line
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: lineController3,
                      onSaved: (val){
                        line3 = lineController3.text;
                      },
                      validator: (String value) {
                        value = value.trim();
                        return syllableValidator(value, 5);
                      },
                      decoration: InputDecoration(
                        hintText: " Enter 5 syllables",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.all(12.0),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            final snackbar = SnackBar(
                              content: Text('Your poem looks good!'),
                            );
                            Scaffold.of(context).showSnackBar(snackbar);
                          }
                        },
                        child: Text(
                          'Check Haiku',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blueAccent)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(12.0),
                        onPressed: () {
                          _formKey.currentState.reset();
                        },
                        child: Text(
                          'Clear Haiku',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blueAccent)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        padding: EdgeInsets.all(12.0),
                        onPressed: () async {
                          _formKey.currentState.save();
                          setState(() {
                          });
                         await share(lineController1, lineController2, lineController3);
                         lineController1.text = line1;
                         lineController2.text = line2;
                         lineController3.text = line3;
                        },
                        child: Text(
                          "Share",
                          style:  TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blueAccent)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

haikuTutorial(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Haiku Helper Tutorial"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Text(
                  "This is the Haiku Helper! It will help you create haikus, by making sure that there are the correct amount of syllables per line."),
              Padding(
                padding: EdgeInsets.all(16.0),
              ),
              Text(
                  "A Haiku is a poetry form created in Japan, that consist of 17 syllables; typically set in three phrases of 5,7,5."),
              Padding(
                padding: EdgeInsets.all(16.0),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "To learn more, check out ",
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  TextSpan(
                      text: "this artical",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchHaikuURL())
                ]),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}


