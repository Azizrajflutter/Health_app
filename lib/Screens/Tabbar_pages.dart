import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_app1/Screens/Schedule_Page.dart';
import 'package:health_app1/Widgets/TabbarButton.dart';

class TabbarPage extends StatefulWidget {
  const TabbarPage({super.key});

  @override
  State<TabbarPage> createState() => _TabbarPageState();
}

class _TabbarPageState extends State<TabbarPage> {
  final controller = PageController(initialPage: 1);
  int selecteIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TabbarButton(
                  onTap: () {
                    setState(() {
                      selecteIndex = 0;
                      controller.jumpToPage(selecteIndex);
                    });
                  },
                  title: 'Canceled Schedule',
                  selected: selecteIndex == 0,
                ),
                SizedBox(
                  width: 12.w,
                ),
                TabbarButton(
                  onTap: () {
                    setState(() {
                      selecteIndex = 1;
                      controller.jumpToPage(selecteIndex);
                    });
                  },
                  title: 'Upcoming schedule',
                  selected: selecteIndex == 1,
                ),
                SizedBox(
                  width: 12.w,
                ),
                TabbarButton(
                  onTap: () {
                    setState(() {
                      selecteIndex = 2;
                      controller.jumpToPage(selecteIndex);
                    });
                  },
                  title: 'Completed schedule',
                  selected: selecteIndex == 2,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Expanded(
              child: PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                selecteIndex = value;
              });
            },
            children: [Text("Nope"), UpComingSchedule(), Text("Nope")],
          ))
        ],
      ),
    );
  }
}
