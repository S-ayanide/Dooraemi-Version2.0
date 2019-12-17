import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final String voicemailOne = 'Sorry! Nobody is at home right now.';
final String voicemailTwo = 'Please, leave the parcel with the neighbour.';
final String voicemailThree = "Please wait a minute, we'll be right there";

String _uid = '1';
String input = '';

DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('Users');

saveVoiceMail() async {
  await _databaseReference.child(_uid).set({
    'VoiceInput': input
  });
}

getVoice() {
  _databaseReference.once().then((DataSnapshot snapshot){
    print('Data: ${snapshot.value}');
  });
}

updateVoice() {
  _databaseReference.child(_uid).update({
    'VoiceInput': 'This is update'
  });
}

createVoicemailDialog(BuildContext context){
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
                width: 305.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.black,
                  onPressed: (){
                    input = voicemailOne;
                    saveVoiceMail();
                  },
                  child: Text(voicemailOne, style: TextStyle(
                    color: Colors.white, 
                    fontSize: 14.0
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 305.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.black,
                  onPressed: (){
                    input = voicemailTwo;
                    saveVoiceMail();
                  },
                  child: Text(voicemailTwo, style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 305.0,
                child: RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.black,
                  onPressed: (){
                    input = voicemailThree;
                    saveVoiceMail();
                  },
                  child: Text(voicemailThree, style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0
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