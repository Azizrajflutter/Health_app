import 'package:flutter/material.dart';
import 'package:health_app1/Screens/Bottom_navi.dart';
import 'package:health_app1/Screens/Register_Page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void sendOtp() async {}
  @override
  Widget build(BuildContext context) => isEmailVerified
      ? bottomnavigationbarPage()
      : RegisterPage(
          email: 'adad',
          Verificationid: '',
        );
}
