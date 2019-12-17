import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

String result = '';
String _uid = '1';

DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('Users');

saveText() async {
  await _databaseReference.child(_uid).set({
    'TextInput': result
  });
}

createTextDialog(BuildContext context){
  return showDialog(context: context, builder: (context){
    return Dialog(
      child: Container(
        color: Color(0xFFF5F5DC),
        height: 300.0,
        width: 350.0,
        child: Card(
          elevation: 15.0,
          color: Color(0xFFF5F5DC),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                child: Text('Type here', style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                width: 250.0,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Your Input here'
                  ),
                  onChanged: (String str){
                    result = str;
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(35.0, 15.0, 35.0, 15.0),
                  color: Colors.black,
                  onPressed: saveText,
                  child: Text('Send', style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}