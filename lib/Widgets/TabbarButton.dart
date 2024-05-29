import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabbarButton extends StatefulWidget {
  final String title;
  final bool selected;
  final Function()? onTap;
  final PageController? controller;
  const TabbarButton({
    super.key,
    required this.title,
    required this.selected,
    this.onTap,
    this.controller,
  });

  @override
  State<TabbarButton> createState() => _TabbarButtonState();
}

class _TabbarButtonState extends State<TabbarButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 50.h,
        width: 226.w,
        decoration: BoxDecoration(
            color: widget.selected
                ? Color.fromRGBO(99, 180, 255, 0.1)
                : Color.fromARGB(255, 255, 249, 249),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: widget.selected
                    ? const Color.fromRGBO(72, 148, 254, 1)
                    : const Color.fromRGBO(134, 150, 187, 1),
                fontSize: widget.selected ? 16.sp : 13.sp),
          ),
        ),
      ),
    );
  }
}
