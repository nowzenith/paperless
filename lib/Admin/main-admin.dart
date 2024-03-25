import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'Appove-2.dart';
import 'adminhome-2.dart';
import 'createnew-2.dart';
import 'profileAdmin-2.dart';

class home_admin extends StatefulWidget {
  const home_admin({super.key});

  @override
  State<home_admin> createState() => _home_adminState();
}

class _home_adminState extends State<home_admin> {
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
              icon: Icon(Icons.manage_search_outlined),
              title: Text(
                'Appove',
                style: TextStyle(fontFamily: 'Lato'),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
            ),
            BottomBarItem(
              icon: Icon(Icons.settings),
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
          children: const <Widget>[
            Adminhome(),
            adminAppove(),
            Createnews(),
            Profileadmin()
          ],
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
