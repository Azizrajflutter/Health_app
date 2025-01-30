import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_app1/Screens/Bottom_navi.dart';
import 'package:health_app1/Services/auth_services.dart';
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
  bool isProgress = false;

  void ResetPassword() async {
    //
    setState(() {
      isProgress = true;
    });
    try {
      var input = ResetemailorPhoneNumberController.text;

      if (input.contains('@') || input.contains('.')) {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: ResetemailorPhoneNumberController.text.trim(),
        );
        // Navigator.pop(context);
        setState(() {
          isProgress = false;
        });
        Get.snackbar('Success',
            'Check Your Email ${ResetemailorPhoneNumberController.text.toString()} was send a Reset Email Link');

        // Navigator.pop(context);
      } else if (RegExp(r'^\+92\d{10}$').hasMatch(input)) {
        User? user = auth.currentUser;
        AuthCredential credential = EmailAuthProvider.credential(
          email: NewPasswordController.text.trim(),
          password: ConfirmPasswordController.text.trim(),
        );
        setState(() {
          isProgress = false;
        });

        await user!.reauthenticateWithCredential(credential);
        await user.updatePassword(NewPasswordController.text.trim());
      } else {
        return ResetemailorPhoneNumberController.clear();
      }
    } catch (e) {
      setState(() {
        isProgress = false;
      });
      Get.snackbar('Failed'.tr, e.toString().trim());
    }
  }

  // void CofnfirmPasswordReset() async {
  //   try {
  //     await auth.confirmPasswordReset(
  //         code: NewPasswordController.text,
  //         newPassword: ConfirmPasswordController.text);
  //     Get.snackbar('Success', 'Your Password  Reset');
  //   } catch (e) {
  //     Get.snackbar('Failed', e.toString());
  //   }
  // }

  void NewPassword() async {
    try {
      User? user = auth.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
        email: NewPasswordController.text.trim(),
        password: ConfirmPasswordController.text.trim(),
      );
      await user!.reauthenticateWithCredential(credential);
      await user.updatePassword(NewPasswordController.text.trim());
    } catch (e) {
      Get.snackbar('Failed'.tr, e.toString().trim());
    }
  }

  Future<void> LoginMethod() async {
    setState(() {
      isProgress = true;
    });
    try {
      await auth.signInWithEmailAndPassword(
          email: emailorPhoneNumberController.text.trim(),
          password: passwordController.text.trim());
      setState(() {
        isProgress = false;
      });
      Get.to(() => bottomnavigationbarPage());
    } catch (e) {
      setState(() {
        isProgress = false;
      });

      Get.snackbar('Failed'.tr, e.toString());
    }
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
  bool obscure = true;
  final _formkey = GlobalKey<FormState>();
  final f1formkey = GlobalKey<FormState>();
  final f2formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        ResetemailorPhoneNumberController.clear();
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
                            "Title2".tr,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.h,
                      ),
                      Text(
                        "emailorPhone".tr,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      MyTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'emailvalidation'.tr;
                          }
                          return null;
                        },
                        usernamecontroller: emailorPhoneNumberController,
                        title: 'emailPhonefield'.tr,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                  Form(
                                    key: f1formkey,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 27),
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
                                            Text('Forget1'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Text(
                                              'enteremailorphone'.tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color:
                                                          const Color.fromRGBO(
                                                              174,
                                                              174,
                                                              174,
                                                              1)),
                                            ),
                                            SizedBox(
                                              height: 28.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "emailorPhone".tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ],
                                            ),
                                            MyTextField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'emailvalidation'.tr;
                                                } else if (RegExp(
                                                        r'^\+92\d{10}$')
                                                    .hasMatch(
                                                        ResetemailorPhoneNumberController
                                                            .text)) {
                                                  return null;
                                                } else if (!value
                                                        .contains('@') ||
                                                    !value.contains('.')) {
                                                  return 'validemailvalidation'
                                                      .tr;
                                                }
                                                return null;
                                              },
                                              usernamecontroller:
                                                  ResetemailorPhoneNumberController,
                                              title: 'emailPhonefield'.tr,
                                              icon: Icons.mail,
                                            ),
                                            SizedBox(
                                              height: 50.h,
                                            ),
                                            MyButton(
                                              text: 'SendCode'.tr,
                                              onTap: () {
                                                if (f1formkey.currentState!
                                                    .validate()) {
                                                  ResetPassword();
                                                  Get.back();
                                                  // Get.bottomSheet(StatefulBuilder(
                                                  //   builder: (BuildContext context,
                                                  //       StateSetter setState) {
                                                  //     return Form(
                                                  //       key: f2formkey,
                                                  //       child: Container(
                                                  //         decoration: BoxDecoration(
                                                  //           borderRadius:
                                                  //               BorderRadius.only(
                                                  //             topLeft:
                                                  //                 Radius.circular(
                                                  //                     16),
                                                  //             topRight:
                                                  //                 Radius.circular(
                                                  //                     16),
                                                  //           ),
                                                  //         ),
                                                  //         width: 365.w,
                                                  //         child: Padding(
                                                  //           padding:
                                                  //               const EdgeInsets
                                                  //                   .symmetric(
                                                  //                   horizontal: 27),
                                                  //           child:
                                                  //               SingleChildScrollView(
                                                  //             child: Column(
                                                  //               crossAxisAlignment:
                                                  //                   CrossAxisAlignment
                                                  //                       .center,
                                                  //               children: [
                                                  //                 SizedBox(
                                                  //                     height: 63.h),
                                                  //                 Text(
                                                  //                     'Reset Password',
                                                  //                     style: Theme.of(
                                                  //                             context)
                                                  //                         .textTheme
                                                  //                         .displaySmall),
                                                  //                 SizedBox(
                                                  //                     height: 16.h),
                                                  //                 Text(
                                                  //                   'You can change password',
                                                  //                   style: Theme.of(
                                                  //                           context)
                                                  //                       .textTheme
                                                  //                       .titleSmall
                                                  //                       ?.copyWith(
                                                  //                           color: const Color
                                                  //                               .fromRGBO(
                                                  //                               174,
                                                  //                               174,
                                                  //                               174,
                                                  //                               1)),
                                                  //                 ),
                                                  //                 SizedBox(
                                                  //                     height: 28.h),
                                                  //                 Row(
                                                  //                   children: [
                                                  //                     Text(
                                                  //                         "Password",
                                                  //                         style: Theme.of(
                                                  //                                 context)
                                                  //                             .textTheme
                                                  //                             .titleSmall),
                                                  //                   ],
                                                  //                 ),
                                                  //                 MyTextField(
                                                  //                   validator:
                                                  //                       (value) {
                                                  //                     if (value!
                                                  //                         .isEmpty) {
                                                  //                       return 'Please enter your password';
                                                  //                     } else if (value
                                                  //                             .length <
                                                  //                         8) {
                                                  //                       return 'Please enter 8 Chracters';
                                                  //                     }
                                                  //                     return null;
                                                  //                   },
                                                  //                   obscure:
                                                  //                       newobscure,
                                                  //                   eyeicon:
                                                  //                       IconButton(
                                                  //                     onPressed:
                                                  //                         () {
                                                  //                       setState(
                                                  //                           () {
                                                  //                         newisVisible =
                                                  //                             !newisVisible;
                                                  //                         newobscure =
                                                  //                             !newobscure;
                                                  //                       });
                                                  //                     },
                                                  //                     icon: Icon(
                                                  //                       Icons
                                                  //                           .visibility,
                                                  //                       color: newisVisible
                                                  //                           ? Colors
                                                  //                               .black
                                                  //                           : Colors
                                                  //                               .grey,
                                                  //                     ),
                                                  //                   ),
                                                  //                   usernamecontroller:
                                                  //                       NewPasswordController,
                                                  //                   title:
                                                  //                       'Password',
                                                  //                   icon:
                                                  //                       Icons.mail,
                                                  //                 ),
                                                  //                 SizedBox(
                                                  //                     height: 24.h),
                                                  //                 Row(
                                                  //                   children: [
                                                  //                     Text(
                                                  //                         "Confirm Password",
                                                  //                         style: Theme.of(
                                                  //                                 context)
                                                  //                             .textTheme
                                                  //                             .titleSmall),
                                                  //                   ],
                                                  //                 ),
                                                  //                 MyTextField(
                                                  //                   validator:
                                                  //                       (value) {
                                                  //                     if (value!
                                                  //                         .isEmpty) {
                                                  //                       return 'Please enter your password';
                                                  //                     } else if (value
                                                  //                             .length <
                                                  //                         8) {
                                                  //                       return 'Please enter 8 Chracters';
                                                  //                     } else if (!value
                                                  //                         .contains(NewPasswordController
                                                  //                             .text
                                                  //                             .toString())) {
                                                  //                       return 'Please enter Same Password';
                                                  //                     }
                                                  //                     return null;
                                                  //                   },
                                                  //                   obscure:
                                                  //                       confirmobscure,
                                                  //                   eyeicon:
                                                  //                       IconButton(
                                                  //                     onPressed:
                                                  //                         () {
                                                  //                       setState(
                                                  //                           () {
                                                  //                         confirmisVisible =
                                                  //                             !confirmisVisible;
                                                  //                         confirmobscure =
                                                  //                             !confirmobscure;
                                                  //                       });
                                                  //                     },
                                                  //                     icon: Icon(
                                                  //                       Icons
                                                  //                           .visibility,
                                                  //                       color: confirmisVisible
                                                  //                           ? Colors
                                                  //                               .black
                                                  //                           : Colors
                                                  //                               .grey,
                                                  //                     ),
                                                  //                   ),
                                                  //                   usernamecontroller:
                                                  //                       ConfirmPasswordController,
                                                  //                   title:
                                                  //                       'Confirm Password',
                                                  //                   icon:
                                                  //                       Icons.mail,
                                                  //                 ),
                                                  //                 SizedBox(
                                                  //                     height: 50.h),
                                                  //                 MyButton(
                                                  //                     text:
                                                  //                         'Reset Password',
                                                  //                     onTap: () {
                                                  //                       if (f2formkey
                                                  //                           .currentState!
                                                  //                           .validate()) {
                                                  //                         CofnfirmPasswordReset();
                                                  //                       }
                                                  //                     }),
                                                  //               ],
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  // ),
                                                  //     barrierColor:
                                                  //         const Color.fromRGBO(
                                                  //             0, 0, 0, 0.2),
                                                  //     backgroundColor:
                                                  //         Colors.white);
                                                }
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  barrierColor:
                                      const Color.fromRGBO(0, 0, 0, 0.2),
                                  backgroundColor: Colors.white);
                            },
                            child: Text(
                              "Forget".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: const Color.fromRGBO(
                                          96, 181, 250, 1)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      MyButton(
                        text: 'SignButton'.tr,
                        onTap: () async {
                          FocusScope.of(context).unfocus();

                          if (_formkey.currentState!.validate()) {
                            LoginMethod();
                          }
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'text2'.tr,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      MyContainer(
                        ontap: () => AuthServices().hadleGoogleSignIn(),
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
