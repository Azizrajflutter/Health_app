import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_app1/Screens/Register_Page.dart';
import 'package:health_app1/Screens/Sign_in.dart';
import 'package:health_app1/Widgets/MyButton.dart';
import 'package:health_app1/Widgets/MyContainer.dart';
import 'package:health_app1/Widgets/MyTextfield.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailorPhoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var emailAuth = EmailAuth(sessionName: "Sample session");
  final _auth = FirebaseAuth.instance;
  void sendOtp() async {}
  Future<void> _signup() async {
    // var input = emailorPhoneNumberController.text.trim();

    // bool isEmail = input.contains('@') && input.contains('.');

    try {
      await emailAuth.sendOtp(
          otpLength: 5, recipientMail: emailorPhoneNumberController.value.text);

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailorPhoneNumberController.text,
              password: passwordController.text);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPage(
              email: emailorPhoneNumberController.value.text,
            ),
          ));

      print('Signed up user: ${userCredential.user}');
    } catch (e) {
      print('Failed to sign up: $e');
      Get.snackbar('Failed', e.toString());
    }
  }

  // bool _isTextNotEmpty = false;
  bool isvisible = false;
  bool obscure = true;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 37.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Text(
                    "Username",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  MyTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    usernamecontroller: usernamecontroller,
                    // isTextNotEmpty: _isTextNotEmpty,
                    title: 'Enter your username',
                    icon: Icons.person_rounded,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Email or Phone number",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  MyTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    usernamecontroller: emailorPhoneNumberController,
                    title: 'Email or phone number',
                    icon: Icons.mail,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Password",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  MyTextField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }

                      return null;
                    },
                    obscure: obscure,
                    eyeicon: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisible = !isvisible;
                            obscure = !obscure;
                          });
                        },
                        icon: Icon(
                          Icons.visibility,
                          color: isvisible ? Colors.black : Colors.grey,
                        )),
                    usernamecontroller: passwordController,
                    // isTextNotEmpty: _isTextNotEmpty,
                    title: 'Password',
                    icon: Icons.lock,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  MyButton(
                    text: 'Create Account',
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        _signup();
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have an account? ',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SignInPage());
                        },
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'or use social account',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  MyContainer(
                    title: 'Continue with Google',
                    image: 'google',
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  MyContainer(title: 'Continue with Twitter', image: 'twiter'),
                  SizedBox(
                    height: 24.h,
                  ),
                  MyContainer(
                    title: 'Continue with Facebook',
                    image: 'fb',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
