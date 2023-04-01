import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transport_app/classroomModule/screens/classroom_screen.dart';

import 'package:transport_app/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: SafeArea(
          child: Container(
        width: dW,
        padding: EdgeInsets.symmetric(horizontal: dW * 0.06),
        child: Column(
          children: [
            SizedBox(
              height: dW * 0.1,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClassRoomScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(dW * 0.03),
                        height: dW * 0.5,
                        width: dW * 0.4,
                        alignment: Alignment.bottomLeft,
                        // color: Colors.red,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: primaryColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Class Room",
                              style: GoogleFonts.lato(
                                  fontSize: tS * 16,
                                  letterSpacing: .56,
                                  fontWeight: FontWeight.w600,
                                  color: whiteColor),
                            ),
                            Text(
                              "Manage Your Classroom",
                              style: GoogleFonts.lato(
                                  fontSize: tS * 10,
                                  letterSpacing: .56,
                                  fontWeight: FontWeight.w400,
                                  color: whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: dW * 0.05),
                    Container(
                      padding: EdgeInsets.all(dW * 0.03),
                      height: dW * 0.45,
                      width: dW * 0.4,
                      alignment: Alignment.bottomLeft,
                      // color: Colors.red,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: primaryColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Students",
                            style: GoogleFonts.lato(
                                fontSize: tS * 16,
                                letterSpacing: .56,
                                fontWeight: FontWeight.w600,
                                color: whiteColor),
                          ),
                          Text(
                            "View Students",
                            style: GoogleFonts.lato(
                                fontSize: tS * 10,
                                letterSpacing: .56,
                                fontWeight: FontWeight.w400,
                                color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(dW * 0.03),
                      height: dW * 0.45,
                      width: dW * 0.4,
                      alignment: Alignment.bottomLeft,
                      // color: Colors.red,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: primaryColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Students",
                            style: GoogleFonts.lato(
                                fontSize: tS * 16,
                                letterSpacing: .56,
                                fontWeight: FontWeight.w600,
                                color: whiteColor),
                          ),
                          Text(
                            "View Students",
                            style: GoogleFonts.lato(
                                fontSize: tS * 10,
                                letterSpacing: .56,
                                fontWeight: FontWeight.w400,
                                color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: dW * 0.05),
                    Container(
                      padding: EdgeInsets.all(dW * 0.03),
                      height: dW * 0.5,
                      width: dW * 0.4,
                      alignment: Alignment.bottomLeft,
                      // color: Colors.red,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: primaryColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Attendance",
                            style: GoogleFonts.lato(
                                fontSize: tS * 16,
                                letterSpacing: .56,
                                fontWeight: FontWeight.w600,
                                color: whiteColor),
                          ),
                          Text(
                            "Today's Attendance",
                            style: GoogleFonts.lato(
                                fontSize: tS * 10,
                                letterSpacing: .56,
                                fontWeight: FontWeight.w400,
                                color: whiteColor),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class HomeOptions extends StatelessWidget {
  const HomeOptions(
      {super.key,
      required this.title,
      required this.function,
      required this.icon});
  final String title;
  final IconData icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: greyColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.01),
              spreadRadius: 0.4,
              blurRadius: .07,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        height: dW * 0.42,
        width: dW * 0.42,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.black45,
            ),
            // Icon(
            //   Icons.person_outline,
            //   color: Colors.grey,
            //   size: 50,
            // ),
            SizedBox(
              height: dW * 0.04,
            ),
            Text(
              title,
              style: TextStyle(fontSize: tS * 15),
            )
          ],
        ),
      ),
    );
  }
}
