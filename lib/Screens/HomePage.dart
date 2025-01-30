import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_app1/Controller/Get_image.dart';
import 'package:health_app1/Screens/Bottom_navi.dart';
import 'package:health_app1/Widgets/Doctor_Intro.dart';
import 'package:health_app1/Widgets/Medical_Field.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'hello'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                    color:
                                        const Color.fromRGBO(134, 150, 187, 1)),
                            children: [
                          TextSpan(
                              text: 'hi'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      fontSize: 20.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700))
                        ])),
                    // Image.asset(
                    //   'assets/Frame.png',
                    //   height: 56.h,
                    // )
                    FutureBuilder(
                      future: FireStoreDataBase().getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false) {
                          return SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => bottomnavigationbarPage(
                                      index: 3,
                                    ));
                              },
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    Iconsax.gallery,
                                    color: Colors.blue,
                                  )),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => bottomnavigationbarPage(
                                      index: 3,
                                    ));
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data.toString()),
                              ),
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(72, 148, 254, 1),
                      borderRadius: BorderRadius.circular(12)),
                  height: 141.h,
                  width: double.infinity.w,
                  child: Column(
                    children: [
                      DoctorTile(
                        colors: Colors.white,
                        image: 'imran',
                        title: 'imran'.tr,
                        subtitle: 'Gn'.tr,
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: const Color.fromRGBO(255, 255, 255, 0.15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.calendar_2,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'imrandate'.tr,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   width: 30.w,
                          // ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                '11:00 - 12:00 AM',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 20),
                  decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 252, 247, 247),
                      filled: true,
                      border: OutlineInputBorder(
                        gapPadding: 12,
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Iconsax.search_normal_14),
                      prefixIconColor: const Color.fromRGBO(134, 150, 187, 1),
                      hintText: 'SearchField'.tr,
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      contentPadding: EdgeInsets.all(14)),
                ),
                SizedBox(
                  height: 24.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 109.h,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MedicalField(
                          image: 'sun',
                          title: 'covid'.tr,
                        ),
                        MedicalField(
                          image: 'profile-add',
                          title: 'doctor'.tr,
                        ),
                        MedicalField(
                          image: 'link',
                          title: 'medicine'.tr,
                        ),
                        MedicalField(
                          image: 'hospital',
                          title: 'Hospital'.tr,
                        )
                      ],
                    ),
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'neardoc'.tr,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 252, 253, 255),
                      borderRadius: BorderRadius.circular(12)),
                  height: 148.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      DoctorTile(
                        image: 'joseph',
                        title: 'drJoseph'.tr,
                        subtitle: 'DS'.tr,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                            ),
                            Text(
                              '1.2 KM',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: const Color.fromRGBO(245, 245, 245, 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'reviews'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.yellow),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   width: 30.w,
                          // ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                'open'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.blue),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
