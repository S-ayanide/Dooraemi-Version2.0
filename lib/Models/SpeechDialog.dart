import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:ui';

class SpeechDialog extends StatefulWidget {
  @override
  _SpeechDialogState createState() => _SpeechDialogState();
}

class _SpeechDialogState extends State<SpeechDialog> {

  SpeechRecognition _speechRecognition;
  static String _uid = '1';

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('Users');

  String resultText = "";

  String lastStatus = "";
  bool isAvailable = false;
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => isAvailable = true),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => isAvailable = true),
    );
  }

  saveAudioInput() async {
    
    await _databaseReference.child(_uid).set({
      'AudioInput': resultText
    });

    setState(() {
      resultText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: isAvailable
          ?  Container(
                color: Color(0xFFF5F5DC),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 15.0,
                  color: Color(0xFFF5F5DC),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                          ),
                          SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: FloatingActionButton(
                              child: Icon(
                                Icons.cancel,
                                size: 32.0,
                              ),
                              mini: true,
                              backgroundColor: Colors.deepOrange,
                              onPressed: (){
                                if (isListening) {
                                  print('Cancel Pressed');
                                  _speechRecognition.cancel().then(
                                    (result) => setState(() {
                                      isListening = result;
                                      resultText = "";
                                    })
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          SizedBox(
                            width: 100.0,
                            height: 100.0,
                            child: FloatingActionButton(
                              child: Icon(
                                Icons.mic,
                                size: 35.0,
                              ),
                              onPressed: (){
                                if (isAvailable && !isListening){
                                  print('Play Pressed');
                                  _speechRecognition
                                    .listen(locale: "en_US")
                                    .then((result) => print(result));
                                }
                              },
                              backgroundColor: Colors.pink,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: FloatingActionButton(
                              child: Icon(
                                Icons.stop,
                                size: 32.0,
                              ),
                              mini: true,
                              backgroundColor: Colors.deepPurple,
                              onPressed: (){
                                if(isListening){
                                  print('Stop Pressed');
                                  _speechRecognition
                                    .stop()
                                    .then((result) => setState(() => isListening = result ));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            color: Color(0xFFf7eaa3),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30.0,
                                ),
                                Center(
                                  child: Text('Your Message', style: TextStyle(
                                    fontSize: 17.0, 
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(resultText), 
                                  )
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.deepPurple,
                        child: Text('Send', style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )),
                        onPressed: saveAudioInput,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: Center(
                          child: isListening ? 
                          Text("I'm listening...", style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0
                            ),
                          )
                          :
                          Text( 'Not listening', style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0
                            ),
                          ),  
                        )
                      ),
                    ],
                  ),
                ),
              )
            : Center( child: Text('Speech recognition unavailable', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
      ),
    );
  }

}