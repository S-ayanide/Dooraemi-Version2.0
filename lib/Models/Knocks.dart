import 'package:flutter/material.dart';

class Knocks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(80.0, 15.0, 80.0, 15.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0
              ),
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Text('7 knocks today', style: TextStyle(fontSize: 19.0),)
          ),
        ],
      ),
    );
  }
}