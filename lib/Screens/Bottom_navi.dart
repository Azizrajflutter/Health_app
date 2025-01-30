import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health_app1/Controller/get_data.dart';
import 'package:health_app1/Screens/Chat_Page.dart';
import 'package:health_app1/Screens/HomePage.dart';
import 'package:health_app1/Screens/Profile_Page.dart';
import 'package:health_app1/Screens/Tabbar_pages.dart';
import 'package:iconsax/iconsax.dart';

class bottomnavigationbarPage extends StatefulWidget {
  final int? index;
  const bottomnavigationbarPage({
    super.key,
    this.index,
  });

  @override
  State<bottomnavigationbarPage> createState() =>
      _bottomnavigationbarPageState();
}

class _bottomnavigationbarPageState extends State<bottomnavigationbarPage> {
  // int slectedIndx = 0;
  // PageController controller = PageController(initialPage: 0);
  late int selectedIndex;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index ?? 0;
    controller = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.put(BottomNavController());
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: GNav(
          onTabChange: (value) {
            bottomNavController.selectedIndex(value);
            controller.jumpToPage(value);
          },
          selectedIndex: selectedIndex,
          tabBorderRadius: 13,
          padding: EdgeInsets.all(12),
          tabBackgroundColor: const Color.fromRGBO(99, 180, 255, 0.1),
          activeColor: Colors.blue,
          color: const Color.fromRGBO(134, 150, 187, 1),
          tabs: [
            GButton(
              gap: 8,
              icon: Iconsax.home_15,
              text: 'Home'.tr,
            ),
            GButton(
              icon: Iconsax.calendar_2,
              text: 'Schedule'.tr,
              gap: 8,
            ),
            GButton(
              icon: Iconsax.message,
              text: 'Chat'.tr,
              gap: 8,
            ),
            GButton(
              icon: Iconsax.profile_circle,
              text: 'Profile'.tr,
              gap: 8,
            )
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [HomePage(), TabbarPage(), ChatPage(), ProfilePage()],
        onPageChanged: (value) {
          bottomNavController.selectedIndex(value);
        },
      ),
    );
  }
}
