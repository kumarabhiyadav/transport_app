import 'package:flutter/material.dart';
import 'package:transport_app/authModule/screens/profile_screen.dart';
import 'package:transport_app/colors.dart';
import 'package:transport_app/communityModule/screens/communityScreen.dart';
import 'package:transport_app/homeModule/home_screen.dart';

class BottomNavigations extends StatefulWidget {
  const BottomNavigations({super.key});

  @override
  State<BottomNavigations> createState() => _BottomNavigationsState();
}

class _BottomNavigationsState extends State<BottomNavigations> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    CommunityScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: "Social",
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "Home",
                backgroundColor: primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
                backgroundColor: primaryColor),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: whiteColor,
          iconSize: 18,
          onTap: _onItemTapped,
          elevation: 1),
    );
  }
}
