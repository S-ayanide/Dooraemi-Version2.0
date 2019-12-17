// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';

// class SpeechDialog extends StatefulWidget {
//   @override
//   _SpeechDialogState createState() => _SpeechDialogState();
// }

// class _SpeechDialogState extends State<SpeechDialog> {

//   bool _hasSpeech = false;
//   String lastWords = "";
//   String lastStatus = "";
//   final SpeechToText speech = SpeechToText();

//   @override
//   void initState() {
//     super.initState();
//     initSpeechState();
//   }

//   Future<void> initSpeechState() async {
//     bool hasSpeech = await speech.initialize(onError: (e) => print(e), onStatus: statusListener );

//     if (!mounted) return;
//     setState(() {
//       _hasSpeech = hasSpeech;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: _hasSpeech
//             ? Container(
//                 color: Color(0xFFF5F5DC),
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: Card(
//                   elevation: 15.0,
//                   color: Color(0xFFF5F5DC),
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 4,
//                       ),
//                       Row(
//                         children: <Widget>[
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width / 5,
//                           ),
//                           SizedBox(
//                             width: 60.0,
//                             height: 60.0,
//                             child: FloatingActionButton(
//                               child: Icon(
//                                 Icons.cancel,
//                                 size: 32.0,
//                               ),
//                               mini: true,
//                               backgroundColor: Colors.deepOrange,
//                               onPressed: cancelListening,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           SizedBox(
//                             width: 100.0,
//                             height: 100.0,
//                             child: FloatingActionButton(
//                               child: Icon(
//                                 Icons.mic,
//                                 size: 35.0,
//                               ),
//                               onPressed: startListening,
//                               backgroundColor: Colors.pink,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           SizedBox(
//                             width: 60.0,
//                             height: 60.0,
//                             child: FloatingActionButton(
//                               child: Icon(
//                                 Icons.stop,
//                                 size: 32.0,
//                               ),
//                               mini: true,
//                               backgroundColor: Colors.deepPurple,
//                               onPressed: stopListening,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 30.0,
//                       ),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Container(
//                             width: MediaQuery.of(context).size.width / 1.5,
//                             color: Color(0xFFf7eaa3),
//                             child: Column(
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 Center(
//                                   child: Text('Your Message', style: TextStyle(
//                                     fontSize: 17.0, 
//                                     fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding: EdgeInsets.all(20.0),
//                                     child: Text(lastWords), 
//                                   )
//                                 ),
//                                 SizedBox(
//                                   height: 20.0,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       RaisedButton(
//                         color: Colors.deepPurple,
//                         child: Text('Send', style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white
//                         )),
//                         onPressed: (){},
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: speech.isListening ? 
//                           Text("I'm listening...", style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 15.0
//                             ),
//                           )
//                           :
//                           Text( 'Not listening', style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 15.0
//                             ),
//                           ),  
//                         )
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : Center( child: Text('Speech recognition unavailable', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
//       ),
//     );
//   }

//   void startListening() {
//     lastWords = "";
//     speech.listen(onResult: resultListener );
//     setState(() {
      
//     });
//   }

//   void stopListening() {
//     speech.stop( );
//     setState(() {
      
//     });
//   }

//   void cancelListening() {
//     speech.cancel( );
//     setState(() {
//       lastWords = "";
//     });
//   }

//   void resultListener(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = "${result.recognizedWords}";
//     });
//   }

//   void statusListener(String status ) {
//     setState(() {
//       lastStatus = "$status";
//     });
//   }
// }