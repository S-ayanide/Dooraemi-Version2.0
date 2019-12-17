import 'package:flutter/material.dart';

class BottomDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 30.0,
        ),
        Container(
          height: 20.0,
          child: Text('Copyright © 2019 Dooraemi'),
        ),
        SizedBox(height: 5.0,),
      ],
    );
  }
}