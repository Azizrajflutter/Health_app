import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalField extends StatelessWidget {
  final String image;
  final String title;
  const MedicalField({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 77.h,
          width: 77.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 255, 251, 251),
          ),
          child: Center(
            child: Image.asset(
              'assets/$image.png',
              height: 24.h,
              width: 24.w,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
