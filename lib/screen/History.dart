import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screen/Profile.dart';
import '../Models/DateTimeFetcher.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  static int recentNumbers = 2;
  final String url = "https://randomuser.me/api/?results=$recentNumbers";
  List data;
  bool isLoading=false;

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
                colors: [Color(0xFF2980B9), Color(0xFF6DD5FA), Color(0xFFFFFFFF)]
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
