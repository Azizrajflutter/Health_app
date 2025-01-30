import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_app1/Model/User_Model.dart';
import 'package:health_app1/Model/helper/Global.dart';
import 'package:health_app1/Widgets/MyButton.dart';
import 'package:health_app1/Widgets/MyTextfield.dart';
import 'package:http/http.dart' as http;

class CanceledScdulePage extends StatefulWidget {
  const CanceledScdulePage({super.key});

  @override
  State<CanceledScdulePage> createState() => _CanceledScdulePageState();
}

class _CanceledScdulePageState extends State<CanceledScdulePage> {
  void login(String email, password, phone, name) async {
    try {
      var response = await http.post(
          Uri.parse(
              'https://umash.hostdonor.com/api/v1/auth/kitchen/registration'),
          body: {
            'name': name,
            'email': email,
            'phone': phone,
            'password': password,
          });
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        // print(data);
        UserModel model = UserModel.fromJson(data);

        await Global.preferences!.setString('userdata', jsonEncode(model));

        var appData = Global.preferences?.getString('userdata');
        // print(appData);
        print('////////////////////');
        if (appData != null) {
          UserModel model2 = UserModel.fromJson(jsonDecode(appData));
          print(model2.toJson());
          print('Login Successfully');
        } else {
          print('Failed to retrieve stored user data.');
        }
      } else {
        print('Failled');
        print('reasion${response.body}');
      }
    } on Exception catch (e) {
      print('$e Login Failled');
    }
  }
  // void login(String email, password, phone, name) async {
  //   try {
  //     var response = await post(
  //         Uri.parse(
  //             'https://umash.hostdonor.com/api/v1/auth/kitchen/registration'),
  //         body: {
  //           'email': email,
  //           'password': password,
  //           'phone': phone,
  //           "name": name
  //         });
  //     if (response.statusCode == 200) {
  //       UserModel model = UserModel.fromJson(jsonDecode(response.body));
  //       print(model.toJson());
  //       print('Success');
  //       Global.preferences?.setString('userdata', response.body);
  //       var data = Global.preferences?.getString('userdata');
  //       print('//////////////////////');
  //       UserModel model2 = UserModel.fromJson(jsonDecode(data!));
  //       print(model2.toJson());
  //     }
  //   } catch (e) {
  //     print("$e Failed");
  //   }
  // }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextField(
                usernamecontroller: _nameController,
                title: 'Name',
                icon: Icons.mail),
            SizedBox(
              height: 40.sp,
            ),
            MyTextField(
                usernamecontroller: _emailController,
                title: 'Email',
                icon: Icons.mail),
            SizedBox(
              height: 40.sp,
            ),
            MyTextField(
                usernamecontroller: _phoneController,
                title: 'Phone',
                icon: Icons.mail),
            SizedBox(
              height: 40.sp,
            ),
            MyTextField(
                usernamecontroller: _passwordController,
                title: 'Password',
                icon: Icons.lock),
            SizedBox(
              height: 10.sp,
            ),
            MyButton(
                text: 'Sign Up',
                onTap: () {
                  setState(() {
                    login(
                        _emailController.text.toString(),
                        _passwordController.text.toString(),
                        _phoneController.text.toString(),
                        _nameController.text.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
