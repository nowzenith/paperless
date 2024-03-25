import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Adminhome extends StatefulWidget {
  const Adminhome({super.key});

  @override
  State<Adminhome> createState() => _AdminhomeState();
}

class _AdminhomeState extends State<Adminhome> {
  final Stream<QuerySnapshot> _historyStream =
      FirebaseFirestore.instance.collection('News').snapshots();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/home.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(-0.6, -0.8),
              child: Container(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.71, -0.67),
              child: Container(
                child: Text(
                  'แอปที่จะช่วยให้การลากิจ\nของคุณนั้นง่ายยิ่งขึ้น',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.75, -0.35),
              child: Container(
                child: Text(
                  'ข่าวสาร',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Container(
                    height: 500,
                    width: 400,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _historyStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            print(data);
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              child: MyWidget(
                                title: data['title'],
                                subtitle: data['subtitle'],
                                image: data['image'],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment(0.8, -0.55),
              child: InkWell(
                child: Container(
                  width: 170,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Color(0xff664731),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 181, 127, 88).withOpacity(0.7),
                        offset: Offset(5, 5),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 13, right: 8, bottom: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 0, right: 10),
                          child: Container(
                            child: Text(
                              'สร้างเอกสาร',
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 35.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  print("tapped on container");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});

  final String title;
  final String subtitle;
  final String image;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  loadimage(String name) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('news-image/$name');
    String url = await ref.getDownloadURL();
    setState(() {
      pic = url;
    });
  }

  String pic = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadimage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, top: 20),
      child: Column(
        children: [
          InkWell(
            child: Stack(children: <Widget>[
              Align(
                  alignment: Alignment(0, -0.5),
                  child: Container(
                    width: 370,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: pic != ""
                            ? Image.network(pic).image
                            : AssetImage('assets/images/download.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: Align(
                  alignment: Alignment(0, -1),
                  child: SizedBox(
                    width: 370,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Color(0xFFFFF4EC),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x33000000),
                            offset: Offset(0, 7),
                            blurRadius: 20,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.title}',
                              style: TextStyle(
                                fontSize: 23,
                                color: Color(0xFF1E1E1E),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                            Text(
                              '${widget.subtitle}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 149, 149, 149),
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            onTap: () {
              print("tapped on container");
            },
          )
        ],
      ),
    );
  }
}
