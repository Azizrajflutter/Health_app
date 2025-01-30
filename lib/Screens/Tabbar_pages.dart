import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app1/Screens/Canceled_sCdule.dart';
import 'package:health_app1/Screens/Completed_sCdue.dart';
import 'package:health_app1/Screens/Schedule_Page.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({super.key});

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int selecteIndex = 1;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 15.h,
        ),
        ButtonsTabBar(
            controller: controller,
            elevation: 0,
            buttonMargin: EdgeInsets.symmetric(horizontal: 8),
            radius: 40,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            unselectedLabelStyle: TextStyle(
                color: const Color.fromRGBO(134, 150, 187, 1),
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontSize: 13.sp),
            labelStyle: TextStyle(
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(72, 148, 254, 1),
            ),
            unselectedBackgroundColor: Color.fromARGB(255, 249, 249, 251),
            backgroundColor: Color.fromARGB(255, 240, 245, 252),
            height: 65.h,
            tabs: [
              Tab(
                text: 'Canceled Schedule',
              ),
              Tab(
                text: 'Upcoming schedule',
              ),
              Tab(
                text: 'Completed schedule',
              )
            ]),
        Expanded(
            child: TabBarView(
          controller: controller,
          children: [
            CanceledScdulePage(),
            UpComingSchedule(),
            CompletedScdue()
          ],
        ))
      ],
    ));
  }
}
