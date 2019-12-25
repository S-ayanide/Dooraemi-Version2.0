import 'dart:io';

import '../../screen/History.dart';
import 'package:flutter/material.dart';
import './HomePageTopPart.dart';
import './HomePageBottomPart.dart';
import '../../Models/Knocks.dart';
import '../../Models/DashboardList.dart';
import '../../Models/Dnd.dart';
import './BottomDesign.dart';
import '../Recent.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  final ScrollController _mycontroller = new ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;    
  String username, email;
  bool isSignedIn = false;
  int selectedPage=0;  
  var dndToggleValue;
  TabController controller;

  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
    this.getUser();  
    dndToggleValue = false;
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SignIn");
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    //ISSUE:  https://github.com/flutter/flutter/issues/19746
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isSignedIn = true;
        username = user.displayName;
        email = user.email;
      });
    } else {
      setState(() {
        username = " ";
        email = " ";
      });
    }
    //print(this.user);
  }

  signOut() async {
    _auth.signOut();
  }

  dndToggle(bool e){
    setState(() {
      dndToggleValue = e;
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dooraemi',style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.account_circle),
            iconSize: 32.0,
            color: Colors.white,
          )
        ],
        backgroundColor: Color(0xFF30336b),
      ),
      drawer: Drawer(
        elevation: 3.0,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(username, style: TextStyle(color: Colors.black),),
              accountEmail: Text(email, style: TextStyle(color: Colors.black)),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/911738/pexels-photo-911738.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                  fit: BoxFit.cover
                )
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://statici.behindthevoiceactors.com/behindthevoiceactors/_img/chars/dorami-doraemon-2005-53.7.jpg'),
              ),
            ),
            ListTile(
              title: Text('Recent'),
              trailing: Icon(Icons.add_to_home_screen),
              onTap: () => Navigator.of(context).pushNamed("/a"),
            ),
            ListTile(
              title: Text('History'),
              trailing: Icon(Icons.history),
              onTap: () => Navigator.of(context).pushNamed("/b"),
            ),
            ListTile(
              title: Text('Do Not Disturb'),
              trailing: Switch(
                value: dndToggleValue,
                onChanged: this.dndToggle,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.lightBlueAccent,
                activeColor: Colors.green,
              ),
            ),
            Divider(
              thickness: 0.5,              
            ),
            ListTile(
              title: Text('Log Out'),
              trailing: Icon(Icons.power_settings_new),
              onTap: signOut
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,             
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  controller: _mycontroller,
                  child: Column(
                    children: <Widget>[
                      HomePageTopPart(),
                      SizedBox(height: 20),
                      HomePageBottomPart(),
                      SizedBox(height: 80),
                      Knocks(),
                      SizedBox(height: 30),
                      Text('Latest Activity', style: TextStyle(
                        fontFamily: 'Cabin',
                        height: 4.0,
                        letterSpacing: 5.0,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20),
                      DashboardList(),
                      SizedBox(height: 50),
                      Dnd(),
                      BottomDesign()
                    ],
                  ),
                )
              ],
            ),     
          ),
          Recent(),
          History()
        ],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        child: TabBar(
          indicatorColor: Colors.orange,
          labelColor: Color(0xFFffbe76),
          unselectedLabelColor: Color(0xFF30336b),
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.call),
              text: 'Recent',
            ),
            Tab(
              icon: Icon(Icons.history),
              text: 'History',
            ),
          ],
          controller: controller,
        ),
      ),
    );
  }
}