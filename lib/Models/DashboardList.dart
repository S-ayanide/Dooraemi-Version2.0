//import 'package:dooraemi/Models/VoiceDialog.dart' as prefix0;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import './DateTimeFetcher.dart';
import '../screen/Profile.dart';
import '../Models/VoicemailDialog.dart';
import '../Models/TextDialog.dart';
import '../Models/SpeechDialog.dart';

class DashboardList extends StatefulWidget {
  @override
  _DashboardListState createState() => _DashboardListState();
}

class _DashboardListState extends State<DashboardList> {
  
  DateTime _date = new DateTime.now();
  //TimeOfDay _time = new TimeOfDay.now();

  final String url = "https://randomuser.me/api/?results=1";
  List data;
  bool isLoading = false;

  Future getData() async {
    var request = await http.get(
      Uri.encodeFull(url)
    );

    List convertDataToJson = jsonDecode(request.body)['results'];
    setState(() {
      data = convertDataToJson;
    });
  }

  @override
  void initState(){
    super.initState();
    this.getData();
    //initSpeechRecognizer();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: isLoading
        ? CircularProgressIndicator()
        : ListView.builder(
          shrinkWrap: true,
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context,i){
            return Card(
              elevation: 20.0,
              color: Color(0xFFe2eff9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: InkWell(
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
                              SizedBox(width: 10.0,),
                              RaisedButton(
                                child: Icon(Icons.mic),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SpeechDialog()
                                  ));
                                },
                                color: Color(0xFFbfb0f7),
                                padding: const EdgeInsets.fromLTRB(20.0,5.0,20.0,5.0),
                              ),
                              RaisedButton(
                                child: Icon(Icons.message),
                                onPressed: (){
                                  createTextDialog(context);
                                },
                                color: Color(0xFF8acaf6),
                                padding: const EdgeInsets.fromLTRB(20.0,5.0,20.0,5.0),
                              ),
                              RaisedButton(
                                child: Icon(Icons.voicemail),
                                onPressed: (){
                                  createVoicemailDialog(context);
                                },
                                color: Color(0xFFfbd0f2),
                                padding: const EdgeInsets.fromLTRB(20.0,5.0,20.0,5.0),
                              ),
                            ],  
                          ),
                          SizedBox(height: 5.0,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}