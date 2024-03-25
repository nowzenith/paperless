import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'homeuser-1.dart';
import 'history-1.dart';
import 'createpaper-1.dart';
import 'profileUser-1.dart';




class home_user extends StatefulWidget {
  const home_user({super.key});

  @override
  State<home_user> createState() => _home_userState();
}

class _home_userState extends State<home_user> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Prompt'),
      home: Scaffold(
        bottomNavigationBar: BottomBar(
          backgroundColor: Color.fromARGB(255, 88, 66, 58),
          selectedIndex: _currentPage,
          height: 100,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(fontFamily: 'Lato'),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
            ),
            BottomBarItem(
              icon: Icon(Icons.watch_later_outlined),
              title: Text(
                'History',
                style: TextStyle(fontFamily: 'Lato'),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
            ),
            BottomBarItem(
              icon: Icon(Icons.document_scanner_outlined),
              title: Text(
                'Create',
                style: TextStyle(fontFamily: 'Lato'),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
            ),
            BottomBarItem(
              icon: Icon(Icons.person_outline),
              title: Text(
                'Profile',
                style: TextStyle(fontFamily: 'Lato'),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: const <Widget>[Userhome(), History(), Create(), Profile()],
          onPageChanged: (index) {
            // Use a better state management solution
            // setState is used for simplicity
            setState(() => _currentPage = index);
          },
        ),
      ),
    );
  }
}
