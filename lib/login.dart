import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gestures/gestures.dart';
import 'package:paperless_newversion/func/login_func.dart';

const brown_color = const Color(0xFF664731);
const background_color = const Color(0xFFF4F4F4);
const textField_color = const Color(0xFFFCFCFD);
const hintTextField_color = const Color(0x801A203D);

bool _isObscured = true;

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  late TextEditingController email_controller;
  late TextEditingController password_controller;
  @override
  void initState() {
    super.initState();
    email_controller = TextEditingController();
    password_controller = TextEditingController();

    /// whenever your initialization is completed, remove the splash screen:
    Future.delayed(Duration(seconds: 5))
        .then((value) => {FlutterNativeSplash.remove()});
  }

  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background_color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: brown_color,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      height: 285,
                      color: brown_color,
                      child: Center(
                        child: Image.asset('assets/images/paperless_icon.png',
                            height: 206,
                            width: 191,
                            alignment: Alignment.center),
                      )),
                ),
                Container(
                  width: double.infinity,
                  height: 285,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Illustration.png'),
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 30),

                Container(
                  child: Text('Login',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  alignment: Alignment.center,
                ),

                SizedBox(height: 29),

                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Container(
                    child: Text('Username', style: TextStyle(fontSize: 16)),
                    alignment: Alignment.centerLeft,
                  ),
                ),

                SizedBox(height: 22),

                //Username input
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: email_controller,
                      autocorrect: false,
                      enableSuggestions: false,
                      style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration
                              .none), // <-- Set the font size here
                      decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: textField_color, //<-- S
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: hintTextField_color),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 22),

                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Container(
                    child: Text('Password', style: TextStyle(fontSize: 16)),
                    alignment: Alignment.centerLeft,
                  ),
                ),

                SizedBox(height: 22),

                //Password input

                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: password_controller,
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: _isObscured,
                      style: TextStyle(
                          fontSize: 16, decoration: TextDecoration.none),
                      decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: textField_color, //<-- SEE HERE
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),

                        hintText: 'Enter your password',

                        hintStyle: TextStyle(color: hintTextField_color),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          child: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Container(
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Forgot your password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //ใส่ได้เลยว่ากด forgot your password แล้วไปไหนต่อ
                                print('Forgot your password has been Clicked');
                              }),
                      ]),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),

                //  child: Text('Forgot your password?',
                //       style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue,),),
                //       alignment: Alignment.centerRight,

                SizedBox(height: 29),

                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    width: 200, // <-- Your width
                    height: 50, // <-- Your height
                    child: ElevatedButton(
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                        primary: brown_color,
                        elevation: 0,
                      ),
                      onPressed: () {
                        login(email_controller.text, password_controller.text)
                            .then((value) => {
                                  FirebaseMessaging.instance
                                      .getToken()
                                      .then((token) => {
                                            FirebaseFirestore.instance
                                                .collection('Users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser?.uid)
                                                .set({
                                              'token': token,
                                            }, SetOptions(merge: true))
                                          })
                                });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
