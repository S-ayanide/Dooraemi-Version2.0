import 'package:flutter/material.dart';

class Dnd extends StatefulWidget {
  @override
  _DndState createState() => _DndState();
}

class _DndState extends State<Dnd> {

  Color gradientOne = Color(0xFF0F2027);
  Color gradientTwo = Color(0xFF203A43);
  Color gradientThree = Color(0xFF2C5364);

  var dndToggleValue;

  @override
  void initState(){
    super.initState();
    dndToggleValue = false;
  }

  dndToggle(bool e){
    setState(() {
      dndToggleValue = e;
    });
    if(dndToggleValue == true){
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('DND is turned on'),
          duration: Duration(seconds: 2),
        )
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('DND is turned off'),
          duration: Duration(seconds: 2),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [gradientOne, gradientTwo, gradientThree])
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('Do Not Disturb', style: TextStyle(
              fontSize: 17.0, 
              color: Colors.white, 
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0
            ),
          ),
          Switch(
            value: dndToggleValue,
            onChanged: this.dndToggle,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.lightBlueAccent,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
      