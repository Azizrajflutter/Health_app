import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_app1/Screens/Bottom_navi.dart';
import 'package:health_app1/Screens/Register_Page.dart';
import 'package:health_app1/Screens/Sign_in.dart';
import 'package:health_app1/Services/auth_services.dart';
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
  bool isvisible = false;
  bool obscure = true;
  bool isProgress = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final FirestoreRef = FirebaseFirestore.instance.collection('New Users');

  @override
  void dispose() {
    usernamecontroller.dispose();
    emailorPhoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    var PhoneNumber = emailorPhoneNumberController.text.trim();
    var input = emailorPhoneNumberController.text.trim();
    bool isEmail = input.contains('@') && input.contains('.');
    bool isPhoneNumber = RegExp(r'^\+92\d{10}$').hasMatch(input);
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => Center(
    //         child: SizedBox(height: 40, child: CircularProgressIndicator())));

    setState(() {
      isProgress = true;
    });
    try {
      if (isEmail) {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: emailorPhoneNumberController.text,
                password: passwordController.text);
        User? user = userCredential.user;

        if (user != null) {
          await FirestoreRef.doc(user.uid).set(
              {'Name': usernamecontroller.text.toString(), 'Uid': user.uid});
        }
        setState(() {
          isProgress = false;
        });
        // Navigator.of(context).pop();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => bottomnavigationbarPage()),
        );
      } else if (isPhoneNumber) {
        await _auth.verifyPhoneNumber(
            phoneNumber: PhoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) async {},
            verificationFailed: (FirebaseAuthException e) {
              print(e.toString());

              // Navigator.of(context).pop();
              setState(() {
                isProgress = false;
              });
              Get.snackbar('Failed'.tr, e.toString());
            },
            codeSent: (String Verificationid, int? resendToken) {
              // Navigator.of(context).pop();
              setState(() {
                isProgress = false;
              });
              Get.snackbar('Success', 'Otp Code Sent to Your Number');

              Get.off(() => RegisterPage(
                    email: PhoneNumber,
                    Verificationid: Verificationid,
                  ));
            },
            codeAutoRetrievalTimeout: (String VerificationId) {});

        // Navigator.of(context).pop();
        setState(() {
          isProgress = false;
        });
        // Get.to(() => RegisterPage(
        //       email: emailorPhoneNumberController.value.text,
        //       Verificationid:'',
        //     ));
      } else {
        // Navigator.of(context).pop();
        setState(() {
          isProgress = false;
        });
      }

      print('Signed up user: ${_auth.currentUser}');
    } catch (e) {
      // Navigator.of(context).pop();
      setState(() {
        isProgress = false;
      });
      print('Failed to sign up: $e');
      Get.snackbar('Failed'.tr, e.toString());
    }
  }

  // bool _isTextNotEmpty = false;

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 37.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Title1".tr,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Text(
                        "userfieldtitle".tr,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      MyTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'usernamevalidation'.tr;
                          }
                          return null;
                        },
                        usernamecontroller: usernamecontroller,
                        // isTextNotEmpty: _isTextNotEmpty,
                        title: 'userfield'.tr,
                        icon: Icons.person_rounded,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "emailorPhone".tr,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      MyTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'emailPhonefield'.tr;
                          } else if (RegExp(r'^\+92\d{10}$')
                              .hasMatch(emailorPhoneNumberController.text)) {
                            return null;
                          } else if (!value.contains('@') ||
                              !value.contains('.')) {
                            return 'validemailvalidation'.tr;
                          }
                          return null;
                        },
                        usernamecontroller: emailorPhoneNumberController,
                        title: 'emailorPhone'.tr,
                        icon: Icons.mail,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        "passwordfield".tr,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      MyTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'passwordvalidation'.tr;
                          } else if (value.length < 8) {
                            return 'passwordvalidationlong'.tr;
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
                        title: 'passwordfield'.tr,
                        icon: Icons.lock,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      MyButton(
                        text: 'CreateButton'.tr,
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            _signup();
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'text2'.tr,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignInPage());
                            },
                            child: Text(
                              'CreatepageButton'.tr,
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
                            'text3'.tr,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      MyContainer(
                        ontap: () => AuthServices().SignInWithGoogle(),
                        title: 'google'.tr,
                        image: 'google',
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      MyContainer(title: 'twitter'.tr, image: 'twiter'),
                      SizedBox(
                        height: 24.h,
                      ),
                      MyContainer(
                        title: 'facebook'.tr,
                        image: 'fb',
                      ),
                    ],
                  ),
                  if (isProgress) CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
