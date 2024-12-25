import 'package:flutter/material.dart';
import 'beranda.dart';
import 'notifikasi.dart';
import 'profile.dart';

class Navigasi extends StatefulWidget {
  @override
  _NavigasiState createState() => _NavigasiState();
}

class _NavigasiState extends State<Navigasi> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    BerandaPage(),
    NotifikasiScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1F4C97),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notifikasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          backgroundColor: Colors.transparent,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedLabelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          selectedIconTheme: IconThemeData(
            color: Colors.white,
            size: 30,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.white.withOpacity(0.6),
            size: 24,
          ),
        ),
      ),
    );
  }
}