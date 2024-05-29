import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
    required this.title,
    required this.image,
    this.ontap,
  });
  final String title;
  final String image;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 248, 248, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity.w,
        height: 50.h,
        child: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/$image.png',
              height: 24.h,
              width: 24.w,
            ),
            SizedBox(
              width: 16.w,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        )),
      ),
    );
  }
}
