import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login.dart';

class Profileadmin extends StatefulWidget {
  const Profileadmin({super.key});

  @override
  State<Profileadmin> createState() => _ProfileadminState();
}

class _ProfileadminState extends State<Profileadmin> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  late String name = "";
  late int remain = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        setState(() {
          name = documentSnapshot['name'];
          remain = documentSnapshot['remain'];
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  async() {
    FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["first_name"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Color(0xFFEFD1BB),
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 1.02),
                child: Container(
                  width: 413.4,
                  height: 505,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-0.85, -0.66),
                        child: Icon(
                          Icons.logout,
                          color: Color(0xFF664731),
                          size: 24,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.06, -0.66),
                        child: InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                            },
                            child: Container(
                              child: Text("ออกจากระบบ",
                                  style: TextStyle(
                                      color: Color.fromRGBO(96, 96, 96, 100))),
                            )),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.04, -0.56),
                        child: Container(
                          width: 372.1,
                          height: 1,
                          decoration: BoxDecoration(
                            color: Color(0xFF606060),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -0.57),
                child: Container(
                  width: 353.8,
                  height: 122.7,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF4EC),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-0.8, 0),
                        child: Container(
                          width: 80,
                          height: 80,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/828/600',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-0.16, -0.9),
                        child: Text('${name}',
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.15, -0.48),
                        child: Text(
                          'บริษัท: เบม จำกัด ตำแหน่ง: admin',
                          style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.21, 0.08),
                        child: Text(
                          'จำนวนลาคงเหลือ  ∞  วัน',
                          style: TextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.9, -0.9),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {},
                  child: Text(
                    'โปรไฟล์',
                    style: TextStyle(
                      fontFamily: 'Prompt',
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
