import 'package:flutter/material.dart';
import 'Onbording_model.dart';

class Onbording extends StatefulWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    ButtonStyle _style = TextButton.styleFrom(
      backgroundColor: Color.fromRGBO(102, 71, 49, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: screens.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(screens[i].img, height: 300),
                        SizedBox(height: 30),
                        Text(
                          screens[i].text,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          screens[i].desc,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              controller: _pageController,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  screens.length, (index) => buildDot(index, context)),
            ),
          ),
          SizedBox(height: 50),
          Container(
            height: 60,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: TextButton(
              child: Text(
                currentIndex == screens.length - 1 ? "Get Started" : "Next",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (currentIndex == screens.length - 1) {
                  //แก้ตรงนี้));
                } else {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.bounceIn);
                }
              },
              style: _style,
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: currentIndex == index
              ? Color.fromRGBO(102, 71, 49, 1)
              : Colors.grey,
          shape: BoxShape.circle),
    );
  }
}
