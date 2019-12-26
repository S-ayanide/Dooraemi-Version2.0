import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screen/Profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Models/DateTimeFetcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/SpeechDialog.dart';
import '../Models/DataList.dart';

class Recent extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  static int recentNumbers = 4;
  final String url = "https://randomuser.me/api/?results=$recentNumbers";  
  bool isLoading=false;
  List data;

  Future getData() async {
    var request = await http.get(
      Uri.encodeFull(url)
    );

    List convertDataToJson = jsonDecode(request.body)['results'];
    setState(() {
      data = convertDataToJson;
    });
  }
  // List<DataList> dataList = [];
  // FirebaseUser user;  
  // DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('Users').child('1');
  // StorageReference _storageReference = FirebaseStorage.instance.ref().child('/');
  // final FirebaseAuth _auth = FirebaseAuth.instance;  

//   getUser() async {
//     FirebaseUser firebaseUser = await _auth.currentUser();
//     //ISSUE:  https://github.com/flutter/flutter/issues/19746
//     await firebaseUser?.reload();    
//     firebaseUser = await _auth.currentUser();

//     if (firebaseUser != null) {
//       setState(() {
//         this.user = firebaseUser;      
//       });
//     }    
//   }

//   void getData()async{   

//   _databaseReference.once().then((DataSnapshot snapshot) {
//     var KEYS = snapshot.value.keys;
//     var DATA = snapshot.value;            

//     dataList.clear();

//     for(var individualKey in KEYS){                
//       DataList data = DataList(
//         DATA[individualKey]['ImageURL'],
//         DATA[individualKey]['TimeStamp']
//       );

//       dataList.add(data);      
//       print(DATA[individualKey]['ImageURL']);
//     }     
//   });  
// }

  @override
  void initState(){
    super.initState();
    //this.getUser();
    this.getData();    
  }

  computeDate(){
    String curDate = findDate() + ' ' + findMonth() + ', ' + findYear();
    return curDate;
  }

  computeTime(){
    String curTime = findHourTime() + ':' + findMinuteTime();
    return curTime;
  }

  computeSeconds(){
    return ', ' + findSecondTime() + ' secs';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFA1FFCE), Color(0xFFFAFFD1)]
              )
            ),
            child: Center(
              child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context,i){
                  return Card(
                    color: Color(0xFFf5f1e6),
                    elevation: 3.0,
                    child: InkWell(
                      highlightColor: Color(0xFFa5cc82),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Profile(
                            date: computeDate(),
                            value: computeTime() + computeSeconds(), 
                            pic: data[i]['picture']['thumbnail']
                          )
                        ));
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Image(
                              image: NetworkImage(data[i]['picture']['thumbnail']),
                              width: 80.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Column(                        
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[                          
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text(
                                        computeDate(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                          fontFamily: 'Amatic',
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 10,
                                      ),
                                      Text(
                                        computeTime(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                          fontFamily: 'Amatic',
                                        ),
                                      ),
                                      Text(
                                        computeSeconds(),
                                        style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 14.0,
                                          fontFamily: 'Cabin',
                                        ),
                                      ),  
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 20.0,),
                                    RaisedButton(
                                      child: Text('Tap to Reply', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => SpeechDialog()
                                        ));
                                      },
                                      color: Color(0xFF30336b),
                                      padding: const EdgeInsets.fromLTRB(20.0,5.0,20.0,5.0),
                                    ),
                                  ],  
                                ),
                                SizedBox(height: 5.0,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
