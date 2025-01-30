import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_app1/Widgets/Doctor_Detail.dart';

class UpComingSchedule extends StatefulWidget {
  const UpComingSchedule({super.key});

  @override
  State<UpComingSchedule> createState() => _UpComingScheduleState();
}

class _UpComingScheduleState extends State<UpComingSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DoctorDetails(
                DocName: 'drJoseph'.tr,
                DocField: 'DS'.tr,
                DocImage: 'joseph',
              ),
              SizedBox(
                height: 16.h,
              ),
              DoctorDetails(
                DocName: 'DrBessie'.tr,
                DocField: 'DS'.tr,
                DocImage: 'bessie',
              ),
              SizedBox(
                height: 16.h,
              ),
              DoctorDetails(
                DocName: 'DrBabe'.tr,
                DocField: 'DS'.tr,
                DocImage: 'babe',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
