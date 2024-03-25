import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Createnews extends StatefulWidget {
  const Createnews({Key? key});

  @override
  State<Createnews> createState() => _CreatenewsState();
}

class _CreatenewsState extends State<Createnews> {
  TextEditingController? controller_Header1, controller_Info1;
  File? imageFile1;
  final storageRef = FirebaseStorage.instance.ref().child("news-image");
  final metadata = SettableMetadata(contentType: "image/jpeg");
  CollectionReference News = FirebaseFirestore.instance.collection('News');
  final Stream<QuerySnapshot> _historyStream =
      FirebaseFirestore.instance.collection('News').snapshots();

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile1 = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile1 != null) {
      setState(() {
        imageFile1 = File(pickedFile1.path);
      });
      print(imageFile1);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller_Header1 = TextEditingController();
    controller_Info1 = TextEditingController();
  }
  //File file;

  final buttonWidth = 300.0;
  final buttonHeight = 50.0;

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
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 110.0),
              child: Container(
                height: 150,
                child: Text(
                  "สร้างข่าวสาร",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
                  SizedBox(
                    width: 450.0,
                    height: 180.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20.0, right: 20.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(255, 255, 255, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        child: imageFile1 == null
                            ? Text(
                                "+ เลือกรูป",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 45,
                                ),
                              )
                            : Image.file(imageFile1!, fit: BoxFit.cover),
                        onPressed: () {
                          _getFromGallery();
                        },
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        controller: controller_Header1,
                        maxLines: 1,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'เขียนหัวข้อข่าว',
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
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        controller: controller_Info1,
                        maxLines: 8,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 7, horizontal: 20),
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
                        'ยืนยัน',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                      onPressed: () {
                        final uploadTask = storageRef
                            .child(basename(imageFile1!.path))
                            .putFile(imageFile1!, metadata);
                        uploadTask.snapshotEvents
                            .listen((TaskSnapshot taskSnapshot) {
                          switch (taskSnapshot.state) {
                            case TaskState.running:
                              final progress = 100.0 *
                                  (taskSnapshot.bytesTransferred /
                                      taskSnapshot.totalBytes);
                              print("Upload is $progress% complete.");
                              break;
                            case TaskState.paused:
                              print("Upload is paused.");
                              break;
                            case TaskState.canceled:
                              print("Upload was canceled");
                              break;
                            case TaskState.error:
                              // Handle unsuccessful uploads
                              break;
                            case TaskState.success:
                              // Handle successful uploads on complete
                              News.doc(controller_Header1!.text)
                                  .set(
                                    {
                                      'title': controller_Header1!.text,
                                      'subtitle': controller_Info1!.text,
                                      'image': basename(imageFile1!.path),
                                    },
                                    SetOptions(merge: true),
                                  )
                                  .then((value) => Alert(
                                        context: context,
                                        type: AlertType.success,
                                        title: "เพิ่มข่าวเรียบร้อย",
                                        desc: "คุณได้เพิ่มข่าวเรียบร้อยแล้ว",
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
                                      ).show())
                                  .catchError((error) => Alert(
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
                                      ).show());
                              break;
                          }
                        });
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
          ],
        ),
      ),
    );
  }
}
