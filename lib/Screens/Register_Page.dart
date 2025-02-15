import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_app1/Screens/Bottom_navi.dart';
import 'package:health_app1/Widgets/MyButton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage(
      {super.key,
      required this.email,
      this.credential,
      required this.Verificationid});
  final String email;
  final String Verificationid;
  final PhoneAuthCredential? credential;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<void> verifyOtp() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.Verificationid, smsCode: OtpController);
      await auth.signInWithCredential(credential);
      Get.bottomSheet(
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            width: 365.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 51.h,
                ),
                Image.asset(
                  'assets/Vector.png',
                  height: 64.h,
                  width: 64.w,
                ),
                SizedBox(
                  height: 37.h,
                ),
                Text('Register Successfully',
                    style: Theme.of(context).textTheme.displaySmall),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27),
                  child: Text(
                    'Congratulations! Your account created successfully. Now you can get amazing experience with our services.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: const Color.fromRGBO(174, 174, 174, 1)),
                  ),
                ),
                SizedBox(
                  height: 28.h,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: MyButton(
                    text: 'Go to HomePage',
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => bottomnavigationbarPage(),
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
          barrierColor: const Color.fromRGBO(0, 0, 0, 0.2),
          backgroundColor: Colors.white);
    } catch (e) {
      Get.snackbar('Failed', e.toString().trim());
    }
  }

  late String OtpController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verification',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 56.h,
              ),
              Image.asset(
                'assets/checkmark.png',
                height: 122.h,
                width: 122.w,
              ),
              SizedBox(
                height: 48.h,
              ),
              Text(
                'Verification Code',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(' We have sent the code to',
                  style: Theme.of(context).textTheme.headlineSmall),
              Text(
                widget.email,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 48.h,
              ),
              OtpTextField(
                margin: EdgeInsets.only(
                  left: 3,
                ),
                contentPadding: EdgeInsets.all(12),
                fieldHeight: 54, fieldWidth: 54,
                numberOfFields: 6,
                borderWidth: 0,
                borderRadius: BorderRadius.circular(10),
                fillColor: const Color.fromRGBO(248, 248, 248, 1),
                filled: true,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  OtpController = verificationCode;
                }, // end onSubmit
              ),
              SizedBox(
                height: 48.h,
              ),
              MyButton(
                text: 'Submit',
                onTap: () {
                  verifyOtp();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn’t receive the code? ',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text('Resend',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.blue))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
