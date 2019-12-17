import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
       appBar: AppBar(
          title: Text("Dooraemi!!"),
          backgroundColor: Colors.green,
        ),
        drawer: Drawer(
          //listview
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  child: Text("Drawer header"),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                ),
              ),
              ListTile(
                title:Text("Recent"),
               /* onTap: (){
                  Navigator.pop(context);
                },*/
              ),
              ListTile(
                title:Text("History"),
                /* onTap: (){
                  Navigator.pop(context);
                },*/
              ),
              ListTile(
                title:Text("DND"),
                /* onTap: (){
                  Navigator.pop(context);
                },*/
              )

            ]

          )
        ),
      ),
    ),
  );
}
