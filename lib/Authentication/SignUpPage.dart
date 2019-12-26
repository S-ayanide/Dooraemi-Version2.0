import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _name, _password;
  static String _uid, _phone;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user){
      if(user != null){
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToSignInScreen(){
    Navigator.pushReplacementNamed(context, "/SignIn");
  }

  @override
  void initState(){
    super.initState();
    this.checkAuthentication();
  }

  void signup() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      
      try {
        FirebaseUser user =await _auth.createUserWithEmailAndPassword(email: _email,password: _password);
        if(user != null){
          UserUpdateInfo userInfo = UserUpdateInfo();
          userInfo.displayName = _name;
          user.updateProfile(userInfo);
        }
      } catch (e) {
        showError(e.message);
      }
    }
  }

  showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF8EFBA),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      //Dooraemi Image
                      Container(
                        child: Image(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height/6,
                          image: AssetImage('assets/SignUp/DooraemiSignUp.png'),
                        ),
                      ),
                      //Name
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an Name';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Your Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          onSaved: (input) => _name = input,
                        ),
                      ),
                      //email
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an email';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Your Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      //password
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password should be 6 char atleast';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Your Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide Your Device UID';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Device UID',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          onSaved: (input) => _uid = input,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide your phone number';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Your Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          onSaved: (input) => _phone = input,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 18),
                        child: RaisedButton(
                          padding:
                              EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          color: Color(0xFFa6946f),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          onPressed: signup,
                          child: Text('Sign Up',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                        ),
                      ),
                      //redirect to signup page
                      GestureDetector(
                        onTap: navigateToSignInScreen,
                        child: Text('Already Have an Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
