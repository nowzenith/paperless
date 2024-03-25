import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paperless_newversion/func/firebase_func.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class adminAppove extends StatefulWidget {
  const adminAppove({super.key});

  @override
  State<adminAppove> createState() => _adminAppoveState();
}

class _adminAppoveState extends State<adminAppove> {
  final Stream<QuerySnapshot> _historyStream =
      FirebaseFirestore.instance.collection('history').snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 270, bottom: 10),
                child: Text(
                  "อนุมัติ",
                  style: TextStyle(
                    color: Color.fromRGBO(30, 30, 30, 1),
                    fontFamily: 'Prompt',
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _historyStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        print(document.id);
                        if (data['status'] == null) {
                          return Appove(
                            type: data['type'],
                            start_date: data['start_date'].toDate(),
                            end_date: data['end_date'].toDate(),
                            name: data['name'],
                            uid: data['user'],
                            des: data['des'],
                            doc: document.id,
                            remain: data['total'],
                          );
                        }
                        return Container();
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Appove extends StatefulWidget {
  const Appove(
      {Key? key,
      required this.type,
      required this.start_date,
      required this.end_date,
      required this.name,
      required this.uid,
      required this.des,
      required this.doc,
      required this.remain})
      : super(key: key);

  final String type;
  final DateTime start_date;
  final DateTime end_date;
  final String name;
  final String des;
  final String doc;
  final String uid;
  final int remain;
  @override
  _AppoveState createState() => _AppoveState();
}

class _AppoveState extends State<Appove> {
  void sendNotification(String token, String title, String body) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAZdrqkw0:APA91bEVpu3HcoCdM03XItzA3xRn0MsWk_lLhdbOm7YwWz63u1erdfiUF6hIWt_htuZo6p7TSycAQdrgE18NP8HMVEIeJAADvxl03F7eXK3hTDsvpuOzktFkva5VWvlz7k1kJmO87o1o'
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
              'android_channel_id': 'dbfood',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            'to': token,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Appove - GROUP

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          width: 338,
          height: 79,
          child: Stack(children: <Widget>[
            Positioned(
                top: 0,
                left: 0,
                child: Container(
                    width: 338,
                    height: 79,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                            offset: Offset(3, 3),
                            blurRadius: 20)
                      ],
                      color: Color.fromRGBO(255, 243, 235, 1),
                    ))),
            Positioned(
                top: 19,
                left: 22,
                child: Text(
                  "${widget.name} - ${widget.type}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(30, 30, 30, 1),
                      fontFamily: 'Prompt',
                      fontSize: 18,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.bold,
                      height: 1),
                )),
            Positioned(
                top: 43,
                left: 22,
                child: Text(
                  "${widget.start_date.day}/${widget.start_date.month}/${widget.start_date.year} - ${widget.end_date.day}/${widget.end_date.month}/${widget.end_date.year}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(148, 148, 148, 1),
                      fontFamily: 'Prompt',
                      fontSize: 10,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                )),
            Positioned(
                top: 25,
                left: 151,
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("Users")
                        .doc(widget.uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        sendNotification(documentSnapshot['token'],
                            "เอกสารการลา", "อนุมัติ");
                      } else {
                        print('Document does not exist on the database');
                      }
                    });
                    FirebaseFirestore.instance
                        .collection('history')
                        .doc(widget.doc)
                        .update({'status': true});
                  },
                  child: Container(
                      width: 85,
                      height: 30,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 85,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                  color: Color.fromRGBO(102, 71, 49, 1),
                                ))),
                        Positioned(
                            top: 9,
                            left: 26,
                            child: Text(
                              'อนุมัติ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Prompt',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            )),
                      ])),
                )),
            Positioned(
                top: 25,
                left: 242,
                child: InkWell(
                  splashColor: Colors.grey,
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection("Users")
                        .doc(widget.uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        sendNotification(documentSnapshot['token'],
                            "เอกสารการลา", "ไม่อนุมัติ");
                      } else {
                        print('Document does not exist on the database');
                      }
                    });

                    FirebaseFirestore.instance
                        .collection('history')
                        .doc(widget.doc)
                        .update({'status': false});
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(widget.uid)
                        .set({'remain': FieldValue.increment(widget.remain)},
                            SetOptions(merge: true));
                  },
                  child: Container(
                      width: 85,
                      height: 30,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: InkWell(
                              splashColor: Colors.black,
                              onTap: () {
                                print("Container was tapped 2");
                                FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(widget.uid)
                                    .get()
                                    .then((DocumentSnapshot documentSnapshot) {
                                  if (documentSnapshot.exists) {
                                    sendNotification(documentSnapshot['token'],
                                        "เอกสารการลา", "ไม่อนุมัติ");
                                  } else {
                                    print(
                                        'Document does not exist on the database');
                                  }
                                });

                                FirebaseFirestore.instance
                                    .collection('history')
                                    .doc(widget.doc)
                                    .update({'status': false});
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(widget.uid)
                                    .set({
                                  'remain': FieldValue.increment(widget.remain)
                                }, SetOptions(merge: true));
                              },
                              child: Container(
                                  width: 85,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  )),
                            )),
                        Positioned(
                            top: 9,
                            left: 20,
                            child: Text(
                              'ไม่อนุมัติ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 71, 49, 1),
                                  fontFamily: 'Prompt',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                            )),
                      ])),
                )),
          ])),
    );
  }
}
