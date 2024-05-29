import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_app1/Screens/Bottom_navi.dart';
import 'package:health_app1/Widgets/MyButton.dart';
import 'package:health_app1/Widgets/MyContainer.dart';
import 'package:health_app1/Widgets/MyTextfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final auth = FirebaseAuth.instance;
  void LoginMethod() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailorPhoneNumberController.text,
          password: passwordController.text);
    } catch (e) {}
  }

  bool newobscure = true;
  bool newisVisible = false;
  bool confirmisVisible = false;
  bool confirmobscure = true;
  TextEditingController emailorPhoneNumberController = TextEditingController();
  TextEditingController ResetemailorPhoneNumberController =
      TextEditingController();
  TextEditingController NewPasswordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isvisible = false;
  bool obscure = false;
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
                        "Sign in",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Text(
                    "Email or Phone number",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  MyTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Email';
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
                      if (value!.isEmpty) {
                        return 'Please enter your Password';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 27),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16))),
                                width: 365.w,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 63.h,
                                      ),
                                      Text('Forgot Password',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Text(
                                        'Enter your email or password',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                                color: const Color.fromRGBO(
                                                    174, 174, 174, 1)),
                                      ),
                                      SizedBox(
                                        height: 28.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Email or Phone number",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                      ),
                                      MyTextField(
                                        usernamecontroller:
                                            ResetemailorPhoneNumberController,
                                        title: 'Email or phone number',
                                        icon: Icons.mail,
                                      ),
                                      SizedBox(
                                        height: 50.h,
                                      ),
                                      MyButton(
                                        text: 'Send Code',
                                        onTap: () {
                                          Get.back();
                                          Get.bottomSheet(StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setState) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16),
                                                    topRight:
                                                        Radius.circular(16),
                                                  ),
                                                ),
                                                width: 365.w,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 27),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(height: 63.h),
                                                        Text('Reset Password',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .displaySmall),
                                                        SizedBox(height: 16.h),
                                                        Text(
                                                          'You can change password',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall
                                                              ?.copyWith(
                                                                  color: const Color
                                                                      .fromRGBO(
                                                                      174,
                                                                      174,
                                                                      174,
                                                                      1)),
                                                        ),
                                                        SizedBox(height: 28.h),
                                                        Row(
                                                          children: [
                                                            Text("Password",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall),
                                                          ],
                                                        ),
                                                        MyTextField(
                                                          obscure: newobscure,
                                                          eyeicon: IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                newisVisible =
                                                                    !newisVisible;
                                                                newobscure =
                                                                    !newobscure;
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons.visibility,
                                                              color:
                                                                  newisVisible
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .grey,
                                                            ),
                                                          ),
                                                          usernamecontroller:
                                                              NewPasswordController,
                                                          title: 'Password',
                                                          icon: Icons.mail,
                                                        ),
                                                        SizedBox(height: 24.h),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "Confirm Password",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall),
                                                          ],
                                                        ),
                                                        MyTextField(
                                                          obscure:
                                                              confirmobscure,
                                                          eyeicon: IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                confirmisVisible =
                                                                    !confirmisVisible;
                                                                confirmobscure =
                                                                    !confirmobscure;
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons.visibility,
                                                              color:
                                                                  confirmisVisible
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .grey,
                                                            ),
                                                          ),
                                                          usernamecontroller:
                                                              ConfirmPasswordController,
                                                          title:
                                                              'Confirm Password',
                                                          icon: Icons.mail,
                                                        ),
                                                        SizedBox(height: 50.h),
                                                        MyButton(
                                                            text:
                                                                'Reset Password',
                                                            onTap: () {}),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                              barrierColor:
                                                  const Color.fromRGBO(
                                                      0, 0, 0, 0.2),
                                              backgroundColor: Colors.white);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              barrierColor: const Color.fromRGBO(0, 0, 0, 0.2),
                              backgroundColor: Colors.white);
                        },
                        child: Text(
                          "Forget Password ?",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: const Color.fromRGBO(96, 181, 250, 1)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  MyButton(
                    text: 'Sign in',
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Get.to(() => bottomnavigationbarPage());
                      if (_formkey.currentState!.validate()) {}
                    },
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
