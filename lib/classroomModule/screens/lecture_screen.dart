import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transport_app/classroomModule/screens/create_lecture_screen.dart';

import '../../colors.dart';
import '../../common_widgets.dart';

class LectureScreen extends StatefulWidget {
  final String classRoom;

  const LectureScreen({super.key, required this.classRoom});

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  @override
  Widget build(BuildContext context) {
    final tS = MediaQuery.of(context).textScaleFactor;
    final dW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: widget.classRoom,
          tS: tS,
          fontSize: 18,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: dW * 0.02, vertical: dW * 0.04),
                  margin: EdgeInsets.symmetric(horizontal: dW * 0.05),
                  width: dW * 0.9,
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          10,
                        ),
                        topRight: Radius.circular(
                          10,
                        ),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Intoduction to history ",
                        tS: tS,
                        color: whiteColor,
                      ),
                      PopupMenuButton<int>(
                        icon: const Icon(
                          Icons.more_vert,
                          color: whiteColor,
                          weight: 10,
                        ),
                        onSelected: (value) {
                          if (value == 1) {
                            print("Download");
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child:
                                CustomText(text: "Download Resources", tS: tS),
                          ),
                        ],
                        // elevation: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: dW * 0.02, vertical: dW * 0.04),
                  width: dW * 0.9,
                  decoration: const BoxDecoration(
                      color: blueShade,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          10,
                        ),
                        bottomRight: Radius.circular(
                          10,
                        ),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text:
                                DateFormat('hh : mm a').format(DateTime.now()),
                            color: primaryColor,
                            tS: tS,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          const Icon(
                            Icons.arrow_forward_sharp,
                            color: primaryColor,
                          ),
                          CustomText(
                            text:
                                DateFormat('hh : mm a').format(DateTime.now()),
                            color: primaryColor,
                            tS: tS,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dW * 0.01,
                      ),
                      CustomText(
                        text: DateFormat('dd MMM yyyy').format(DateTime.now()),
                        color: primaryColor,
                        tS: tS,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: CustomText(
          text: 'Create Lecture',
          tS: tS,
          color: Colors.white,
        ),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateLecture()));
        },
      ),
    );
  }
}
