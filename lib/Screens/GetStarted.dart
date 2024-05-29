import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_app1/Screens/AccountCreate.dart';
import 'package:health_app1/Widgets/MyButton.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Gallery.png',
              height: 268.h,
            ),
            SizedBox(
              height: 29.r,
            ),
            Text('Lorem ipsum is a placeholder',
                style: Theme.of(context).textTheme.bodyLarge),
            Text('LoremIpsum', style: Theme.of(context).textTheme.bodySmall),
            SizedBox(
              height: 74.r,
            ),
            MyButton(
              text: 'Get Started',
              onTap: () {
                Get.to(() => CreateAccountPage());
              },
            )
          ],
        ),
      ),
    );
  }
}
