import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health_app1/Screens/HomePage.dart';
import 'package:health_app1/Screens/Tabbar_pages.dart';
import 'package:iconsax/iconsax.dart';

class bottomnavigationbarPage extends StatefulWidget {
  const bottomnavigationbarPage({super.key});

  @override
  State<bottomnavigationbarPage> createState() =>
      _bottomnavigationbarPageState();
}

class _bottomnavigationbarPageState extends State<bottomnavigationbarPage> {
  int slectedIndx = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: GNav(
          onTabChange: (value) {
            setState(() {
              slectedIndx = value;
              controller.jumpToPage(slectedIndx);
            });
          },
          selectedIndex: slectedIndx,
          tabBorderRadius: 13,
          padding: EdgeInsets.all(12),
          tabBackgroundColor: const Color.fromRGBO(99, 180, 255, 0.1),
          activeColor: Colors.blue,
          color: const Color.fromRGBO(134, 150, 187, 1),
          tabs: [
            GButton(
              gap: 8,
              icon: Iconsax.home_15,
              text: 'Home',
            ),
            GButton(
              icon: Iconsax.calendar_2,
              text: 'Schedule',
              gap: 8,
            ),
            GButton(
              icon: Iconsax.message,
              text: 'Chat',
              gap: 8,
            ),
            GButton(
              icon: Iconsax.profile_circle,
              text: 'Profile',
              gap: 8,
            )
          ],
        ),
      ),
      body: PageView(
        controller: controller,
        children: [
          HomePage(),
          TabbarPage(),
        ],
        onPageChanged: (value) {
          setState(() {
            slectedIndx = value;
          });
        },
      ),
    );
  }
}
