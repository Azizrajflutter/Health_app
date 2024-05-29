import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 50.h,
        width: double.infinity.w,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(74, 171, 248, 1),
                Color.fromRGBO(117, 194, 255, 1),
                Color.fromRGBO(74, 171, 248, 1),
                Color.fromRGBO(153, 210, 255, 1),
              ],
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              // stops: [0.0, 0.3, 0.7, 1.0], // Adjust stops as needed
              // tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
