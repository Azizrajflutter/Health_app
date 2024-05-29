import 'package:flutter/material.dart';

class DoctorTile extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Color? colors;
  const DoctorTile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.colors,
  });

  @override
  State<DoctorTile> createState() => _DoctorTileState();
}

class _DoctorTileState extends State<DoctorTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 38,
          child: Image.asset('assets/${widget.image}.png'),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: widget.colors),
            ),
            SizedBox(height: 8), // Adjust the height value to change the gap
            Text(
              widget.subtitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        horizontalTitleGap: -2,
        subtitleTextStyle: Theme.of(context).textTheme.titleMedium,
        trailing: widget.trailing);
  }
}
