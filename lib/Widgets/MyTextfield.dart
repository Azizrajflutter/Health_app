import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      required this.usernamecontroller,
      // required bool isTextNotEmpty,
      this.obscure = false,
      this.eyeicon,
      required this.title,
      required this.icon,
      this.validator});

  final TextEditingController usernamecontroller;
  // final bool _isTextNotEmpty;
  final bool obscure;
  final IconButton? eyeicon;
  final String title;
  final IconData icon;
  final String? Function(String?)? validator;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool textnotEmpty = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty) {
          setState(() {
            textnotEmpty = true;
          });
        } else {
          setState(() {
            textnotEmpty = false;
          });
        }
      },
      obscureText: widget.obscure,
      controller: widget.usernamecontroller,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: widget.eyeicon,
        contentPadding: EdgeInsets.all(13),
        prefixIcon: Icon(
          widget.icon,
          color: textnotEmpty
              ? Colors.blue
              : Theme.of(context).colorScheme.onPrimary,
        ),
        hintText: widget.title,
        hintStyle: Theme.of(context).textTheme.labelSmall,
        filled: true,
        fillColor: Color.fromRGBO(248, 248, 248, 1),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red)),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
