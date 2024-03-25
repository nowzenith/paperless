import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final Stream<QuerySnapshot> _historyStream =
      FirebaseFirestore.instance.collection('history').snapshots();
  final user = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 260,
                  ),
                  child: Text(
                    "ประวัติ",
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
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          print(data);
                          if (data['user'] == user) {
                            if (data['status'] != null) {
                              return my_widget(
                                  type: data['type'],
                                  start_date: data['start_date'].toDate(),
                                  end_date: data['end_date'].toDate(),
                                  status: data['status']);
                            }
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
      ),
    );
  }
}

class my_widget extends StatefulWidget {
  const my_widget({
    super.key,
    required this.type,
    required this.start_date,
    required this.end_date,
    required this.status,
  });

  final String type;
  final DateTime start_date;
  final DateTime end_date;
  final bool status;

  @override
  State<my_widget> createState() => _my_widgetState();
}

class _my_widgetState extends State<my_widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
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
                              color:
                                  Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                              offset: Offset(3, 3),
                              blurRadius: 20)
                        ],
                        color: Color.fromRGBO(255, 243, 235, 1),
                      ))),
              Positioned(
                  top: 0,
                  left: 214,
                  child: Container(
                      width: 124,
                      height: 79,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(15),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                              offset: Offset(3, 3),
                              blurRadius: 20)
                        ],
                        color: widget.status
                            ? Color.fromRGBO(78, 139, 0, 1)
                            : Color.fromRGBO(163, 0, 0, 1),
                      ))),
              Positioned(
                  top: 19,
                  left: 22,
                  child: Text(
                    "${widget.type}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        fontFamily: 'Prompt',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1),
                  )),
              Positioned(
                  top: 33,
                  left: 256,
                  child: Text(
                    widget.status ? 'อนุมัติ' : 'ไม่อนุมัติ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Prompt',
                        fontSize: 14,
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
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
            ])));
  }
}
