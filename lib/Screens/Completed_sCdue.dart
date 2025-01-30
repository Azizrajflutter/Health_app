import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:health_app1/Widgets/MyButton.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:health_app1/Model/User_Model.dart';
import 'package:health_app1/Model/helper/Global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CompletedScdue extends StatefulWidget {
  const CompletedScdue({super.key});

  @override
  State<CompletedScdue> createState() => _CompletedScdueState();
}

class _CompletedScdueState extends State<CompletedScdue> {
  File? image;
  final _picker = ImagePicker();
  bool isProgress = false;
  Future PickImage() async {
    final PickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (PickedFile != null) {
      setState(() {
        image = File(PickedFile.path);
      });
    }
  }

  Future<void> UploadImage() async {
    try {
      setState(() {
        isProgress = true;
      });
      var stream = new http.ByteStream(image!.openRead());
      stream.cast();
      var length = await image!.length();
      var uri = Uri.parse('https://fakestoreapi.com/products');
      var request = new http.MultipartRequest('POST', uri);
      request.fields['title'] = 'Static title';
      var multiport = new http.MultipartFile(
        'image',
        stream,
        length,
      );
      request.files.add(multiport);
      var response = await request.send();
      if (response.statusCode == 200) {
        setState(() {
          isProgress = false;
        });

        print('Succes');
      }
    } catch (e) {
      setState(() {
        isProgress = false;
      });
      print('$e Failled');
    }
  }

  late UserModel userModel;
  void userdata() {
    final user = Global.preferences!.getString('userdata');
    userModel = UserModel.fromJson(jsonDecode(user!));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userdata();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isProgress,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 140,
                width: 140,
                child: GestureDetector(
                  onTap: () {
                    PickImage();
                  },
                  child: CircleAvatar(
                      backgroundImage:
                          image != null ? FileImage(image!.absolute) : null,
                      child: image == null ? Text('Select Image') : null),
                )),
            SizedBox(
              height: 30,
              width: 400,
            ),
            Text('Name  : ${userModel.user.fName}'),
            Text('Email  :${userModel.user.email}'),
            Text('Phone  :${userModel.user.phone}'),
            MyButton(
                text: 'Upload',
                onTap: () {
                  UploadImage();
                })
          ],
        ),
      ),
    );
  }
}
