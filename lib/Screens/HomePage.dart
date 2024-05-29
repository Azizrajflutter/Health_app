import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Hello',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                    color:
                                        const Color.fromRGBO(134, 150, 187, 1)),
                            children: [
                          TextSpan(
                              text: '\nHi James',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      fontSize: 20.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700))
                        ])),
                    Image.asset(
                      'assets/Frame.png',
                      height: 56.h,
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
                        title: 'Dr.Imran Syahir',
                        subtitle: 'General Doctor',
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
                        children: [
                          Icon(
                            Iconsax.calendar_2,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            'Sunday, 12 June',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            '11:00 - 12:00 AM',
                            style: Theme.of(context).textTheme.headlineMedium,
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
                      hintText: 'Search doctor or health issue',
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      contentPadding: EdgeInsets.all(14)),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MedicalField(
                      image: 'sun',
                      title: 'Covid 19',
                    ),
                    MedicalField(
                      image: 'profile-add',
                      title: 'Doctor',
                    ),
                    MedicalField(
                      image: 'link',
                      title: 'Medicine',
                    ),
                    MedicalField(
                      image: 'hospital',
                      title: 'Hospital',
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Near Doctor',
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
                        title: 'Dr. Joseph Brostito',
                        subtitle: 'Dental Specialist',
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
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            '4,8 (120 Reviews)',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.yellow),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            'Open at 17.00',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: Colors.blue),
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
