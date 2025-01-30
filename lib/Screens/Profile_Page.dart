import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health_app1/Controller/Get_image.dart';
import 'package:health_app1/Screens/GetStarted.dart';
import 'package:health_app1/Widgets/MyButton.dart';
import 'package:health_app1/Widgets/Toast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? image;
  final FirestoreRef = FirebaseFirestore.instance.collection('New Users');

  final picker = ImagePicker();
  Future GetProfilePic() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (PickedFile != null) {
      setState(() {
        image = File(PickedFile.path);
      });
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref('/foldename/' + user!.uid);
      firebase_storage.UploadTask uploadTask = ref.putFile(image!.absolute);
      Future.value(uploadTask).then((value) async {
        // setState(() {
        //   loading = false;
        // });
        var newUrl = await ref.getDownloadURL();

        await FirestoreRef.doc(user!.uid).update({
          'Url': newUrl.toString(),
        }).then((value) {
          Utils().ToastMessage('Image Added', context);
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
        });
      }).onError((error, stackTrace) {
        Utils().ToastMessage(error.toString(), context);
        // setState(() {
        //   loading = false;
        // });
      });
    } else {
      print('No Image Pic ========');
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  void Logout() async {
    final user = FirebaseAuth.instance;
    try {
      await user.signOut();
      await GoogleSignIn().signOut();
      Get.to(() => GetStarted());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          leadingWidth: 42.r,
          actions: [
            Icon(
              Iconsax.notification,
              size: 32,
            )
          ],
          leading: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromRGBO(217, 217, 217, 1)),
            child: Center(
              child: Icon(Iconsax.arrow_left_24),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: FireStoreDataBase().getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error');
                  }
                  // if (image == null) {
                  //   return SizedBox(
                  //       height: 140,
                  //       width: 140,
                  //       child: CircleAvatar(
                  //         backgroundColor: Colors.grey,
                  //       ));
                  // }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Waiting for Internet!',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return GestureDetector(
                      onTap: () {
                        GetProfilePic();
                      },
                      child: SizedBox(
                        height: 145,
                        width: 150,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: SizedBox(
                            height: 140,
                            width: 140,
                            child: CircleAvatar(
                              backgroundImage: image != null
                                  ? FileImage(image!.absolute)
                                  : null,
                              child: image != null
                                  ? null
                                  : SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            snapshot.data.toString()),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Container(
                height: 25.h,
                width: 60,
                padding: EdgeInsets.only(left: 10),
                child: StreamBuilder(
                  stream: FirestoreRef.where('Uid', isEqualTo: user?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Has Error Occure');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      Text('Waiting..');
                    }
                    if (snapshot.hasData == false) {
                      return Text('No Name');
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Text(
                            snapshot.data?.docs[index]['Name'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 17),
                          );
                        },
                      );
                    }
                    return Text("User Name");
                  },
                ),
              ),

              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${user?.email.toString()}"),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Iconsax.edit,
                    size: 24.r,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                indent: 15,
                endIndent: 15,
                color: Colors.grey,
              ),
              PrfileTile(
                title: 'order',
                icon: Iconsax.bag_2,
              ),
              PrfileTile(
                title: 'favorites',
                icon: Iconsax.heart,
              ),
              PrfileTile(
                title: 'history',
                icon: Iconsax.clock,
              ),
              Divider(
                indent: 15,
                endIndent: 15,
                color: Colors.grey,
              ),
              PrfileTile(
                title: 'features',
                icon: Iconsax.clipboard_text,
              ),
              PrfileTile(
                title: 'validity',
                icon: Iconsax.calendar5,
              ),
              PrfileTile(
                title: 'FAQs',
                icon: Iconsax.message_question,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            height: 321.sp,
                            width: 200,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Language',
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                LanguageTile(
                                  language: 'English',
                                  img: 'en',
                                  ontap: () {
                                    setState(() {
                                      Get.updateLocale(Locale('en'));
                                    });
                                    Get.back();
                                  },
                                ),
                                Divider(),
                                LanguageTile(
                                  language: 'Deutsch',
                                  img: 'German',
                                  ontap: () {
                                    setState(() {
                                      Get.updateLocale(Locale('de'));
                                    });
                                    Get.back();
                                  },
                                ),
                                Divider(),
                                LanguageTile(
                                  language: 'Española',
                                  img: 'es',
                                  ontap: () {
                                    setState(() {
                                      Get.updateLocale(Locale('es'));
                                    });
                                    Get.back();
                                  },
                                ),
                                Divider(),
                                LanguageTile(
                                  language: 'Français',
                                  img: 'fr',
                                  ontap: () {
                                    setState(() {
                                      Get.updateLocale(Locale('fr'));
                                    });
                                    Get.back();
                                  },
                                ),
                                Divider(),
                                LanguageTile(
                                  ontap: () {
                                    setState(() {
                                      Get.updateLocale(Locale('it'));
                                    });
                                    Get.back();
                                  },
                                  language: 'Italiana',
                                  img: 'it',
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: PrfileTile(
                  title: 'languages',
                  icon: Iconsax.language_square,
                ),
              ),
              MyButton(
                  text: 'Log Out',
                  onTap: () {
                    Logout();
                  })
              // GestureDetector(
              //   onTap: () => Logout(),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: const Color.fromRGBO(254, 101, 36, 1),
              //         borderRadius: BorderRadius.circular(15)),
              //     width: 280.w,
              //     height: 55.h,
              //     child: Center(
              //       child: Text(
              //         'Log Out',
              //         style: Theme.of(context)
              //             .textTheme
              //             .labelLarge
              //             ?.copyWith(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // )
              // MyButton(
              //     text: 'Spanish',
              //     onTap: () {
              // setState(() {
              //   Get.updateLocale(Locale('es'));
              // });
              // }),
              // SizedBox(
              //   height: 10.h,
              // ),
              // MyButton(
              //     text: 'French',
              //     onTap: () {
              //       setState(() {
              //         Get.updateLocale(Locale('fr'));
              //       });
              //     }),
              // SizedBox(
              //   height: 10.h,
              // ),
              // MyButton(
              //     text: 'Italian',
              //     onTap: () {
              //       setState(() {
              //         Get.updateLocale(Locale('it'));
              //       });
              //     }),
              // SizedBox(
              //   height: 10.h,
              // ),
              // MyButton(
              //     text: 'English',
              //     onTap: () {
              //       setState(() {
              //         Get.updateLocale(Locale('en'));
              //       });
              //     }),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Text(user!.email.toString()),
              // MyButton(
              //     text: 'Logout',
              //     onTap: () {
              //       Logout();
              //     })
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String language;
  final String img;
  final void Function()? ontap;
  const LanguageTile({
    super.key,
    required this.language,
    required this.img,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage('assets/$img.png')),
          SizedBox(
            width: 8.w,
          ),
          Text(
            language,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class PrfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const PrfileTile({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleTextStyle: Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
      title: Text(title.tr),
      leading: Container(
        height: 30.r,
        width: 30.r,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            shape: BoxShape.rectangle,
            color: Color.fromARGB(255, 229, 229, 231)),
        child: Icon(
          icon,
          color: const Color.fromRGBO(72, 148, 254, 1),
        ),
      ),
    );
  }
}
