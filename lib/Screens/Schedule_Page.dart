import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                DocName: 'Dr. Joseph Brostito',
                DocField: 'Dental Specialist',
                DocImage: 'joseph',
              ),
              SizedBox(
                height: 16.h,
              ),
              DoctorDetails(
                DocName: 'Dr. Bessie Coleman',
                DocField: 'Dental Specialist',
                DocImage: 'bessie',
              ),
              SizedBox(
                height: 16.h,
              ),
              DoctorDetails(
                DocName: 'Dr. Babe Didrikson',
                DocField: 'Dental Specialist',
                DocImage: 'babe',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
