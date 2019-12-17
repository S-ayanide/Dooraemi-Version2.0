import 'package:flutter/material.dart';
import '../../Models/RadialProgress.dart';

class HomePageBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            RadialProgress(),
            SizedBox(width: 80),
            Column(
              children: <Widget>[
                Text('Recent', style: TextStyle(
                  fontSize: 30, 
                  fontWeight: FontWeight.bold),
                ),
                Text('Activities', style: TextStyle(fontSize: 25),),
              ],
            ),
          ],
        )
      ],
    );
  }
}