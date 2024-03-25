import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

String EndDate = "โปรดระบุวันสิ้นสุด";
String StartDate = 'โปรดระบุวันที่เริ่ม';

int counter = 0;

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
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

  final List<String> items = [
    'ลาป่วย',
    'ลากิจ',
    'ลาคลอด',
    'ลาบวช',
    'ลาพักร้อน',
  ];
  String? selectedValue;
  final buttonWidth = 300.0;
  final buttonHeight = 50.0;

  final user = FirebaseAuth.instance.currentUser?.uid;
  int remain = 0;
  String token = "";
  String name = "";
  String EndDate = "โปรดระบุวันสิ้นสุด";
  String StartDate = 'โปรดระบุวันที่เริ่ม';
  DateTime start_date = DateTime.now();
  DateTime end_date = DateTime.now();
  TextEditingController desController = TextEditingController();

  @override
  void initState() {
    super.initState();
    desController = TextEditingController();
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
          token = documentSnapshot['token'];
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void StartDatePicker(BuildContext context) {
    BottomPicker.date(
      title: 'Set Date',
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color.fromARGB(255, 102, 71, 49),
      ),
      onSubmit: (index) {
        setState(() {
          start_date = DateUtils.dateOnly(index);
          StartDate = DateFormat.yMMMd().format(index);
        });
        print(index);
      },
      gradientColors: [
        Color.fromARGB(255, 102, 71, 49),
        Color.fromARGB(255, 102, 71, 49)
      ],
    ).show(context);
  }

  void EndDatePicker(BuildContext context) {
    BottomPicker.date(
      title: 'Set Date',
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color.fromARGB(255, 102, 71, 49),
      ),
      gradientColors: [
        Color.fromARGB(255, 102, 71, 49),
        Color.fromARGB(255, 102, 71, 49)
      ],
      onSubmit: (index) {
        setState(() {
          end_date = DateUtils.dateOnly(index);
          EndDate = DateFormat.yMMMd().format(index);
        });
        print(index);
      },
    ).show(context);
  }

  @override
  void dispose() {
    desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 209, 187),
      body: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 110.0),
                child: Container(
                  height: 150,
                  child: Text(
                    "สร้างเอกสารการลา",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(20),
                ),
              ),
              Container(
                height: 575,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 1000,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20.0, right: 20.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'โปรดระบุหัวข้อการลา',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 120, 116, 116),
                                ),
                              ),
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF000000),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 0),
                            child: Container(
                              height: 60,
                              child: SizedBox(
                                height: buttonHeight,
                                width: buttonWidth,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 255, 255, 255)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      StartDatePicker(context);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        StartDate,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(120, 116, 116, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 0, right: 20.0),
                            child: Container(
                              width: 150,
                              height: 60,
                              child: SizedBox(
                                height: buttonHeight,
                                width: buttonWidth,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 255, 255, 255)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                            width: 2,
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      EndDatePicker(context);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        EndDate,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(120, 116, 116, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextField(
                          controller: desController,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 8,
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: 'เขียนคำอธิบายเพิ่มเติม',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.0,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(102, 71, 49, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        child: Text(
                          'ส่งเอกสาร',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                        onPressed: () {
                          print(start_date);
                          print(end_date);
                          print(selectedValue);
                          print(desController.text);
                          print(end_date.difference(start_date).inDays + 1);
                          if (StartDate == 'เลือกวันที่เริ่มต้น' ||
                              EndDate == 'เลือกวันที่สิ้นสุด' ||
                              selectedValue == 'เลือกประเภทเอกสาร' ||
                              desController.text == '') {
                            Alert(
                              context: context,
                              type: AlertType.error,
                              title: "Error",
                              desc: "กรุณากรอกข้อมูลให้ครบถ้วน",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "ตกลง",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ).show();
                          } else {
                            if (end_date.difference(start_date).inDays + 1 >
                                remain) {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "Error",
                                desc: "วันลาเกินกำหนด",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "ตกลง",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              ).show();
                            } else {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "ยืนยันการส่งเอกสาร",
                                desc: "คุณต้องการส่งเอกสารใช่หรือไม่",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "ยกเลิก",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.of(context,
                                            rootNavigator: true)
                                        .pop(),
                                  ),
                                  DialogButton(
                                    child: Text(
                                      "ยืนยัน",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(user)
                                          .set({
                                        'remain': remain -
                                            (end_date
                                                .difference(start_date)
                                                .inDays)
                                      }, SetOptions(merge: true));
                                      FirebaseFirestore.instance
                                          .collection('history')
                                          .add({
                                        'type': selectedValue,
                                        'des': desController.text,
                                        'start_date': start_date,
                                        'end_date': end_date,
                                        'user': user,
                                        'name': name,
                                        'total': end_date
                                                .difference(start_date)
                                                .inDays +
                                            1,
                                      }).then((value) {
                                        FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc("6cnOISlhRyXOI3sJw15ZLlhmwGl1")
                                            .get()
                                            .then((DocumentSnapshot
                                                documentSnapshot) {
                                          if (documentSnapshot.exists) {
                                            sendNotification(
                                                documentSnapshot['token'],
                                                'มีเอกสารใหม่',
                                                'มีเอกสารใหม่จาก $name');
                                          } else {
                                            print(
                                                'Document does not exist on the database');
                                          }
                                        });
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        Alert(
                                          context: context,
                                          type: AlertType.success,
                                          title: "ส่งเอกสารสำเร็จ",
                                          desc: "คุณได้ส่งเอกสารเรียบร้อยแล้ว",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "ตกลง",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                            )
                                          ],
                                        ).show();
                                      }).catchError((error) {
                                        Navigator.of(context).pop();
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title: "Error",
                                          desc: "มีบางอย่างผิดพลาด",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "ตกลง",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                            )
                                          ],
                                        ).show();
                                      });
                                    },
                                  ),
                                ],
                              ).show();
                            }
                          }
                        },
                      ),
                    ),
                  ]
                      .map((e) => Padding(
                            child: e,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ))
                      .toList(),
                ),
              ),
            ]),
      ),
    );
  }
}
