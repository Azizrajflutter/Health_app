import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_app1/Widgets/Doctor_Intro.dart';
import 'package:iconsax/iconsax.dart';

class DoctorDetails extends StatelessWidget {
  final String DocName;
  final String DocField;
  final String DocImage;
  const DoctorDetails({
    super.key,
    required this.DocName,
    required this.DocField,
    required this.DocImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 255, 252, 252)),
      height: 205.h,
      width: double.infinity.w,
      child: Column(
        children: [
          DoctorTile(
            image: DocImage,
            title: DocName,
            subtitle: DocField,
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ),
          Divider(
            thickness: 1,
            color: const Color.fromRGBO(245, 245, 245, 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.calendar_2,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    'Sunday, 12 June',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ],
              ),
              // SizedBox(
              //   width: 30.w,
              // ),
              Row(
                children: [
                  Icon(
                    Iconsax.clock,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    '11:00 - 12:00 AM',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Center(
              child: Text(
                'Details'.tr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondaryContainer),
              ),
            ),
          )
        ],
      ),
    );
  }
}
