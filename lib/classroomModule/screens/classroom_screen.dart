import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transport_app/classroomModule/screens/lecture_screen.dart';
import 'package:transport_app/classroomModule/widgets/create_classroom_widget.dart';
import 'package:transport_app/colors.dart';
import 'package:transport_app/common_widgets.dart';

class ClassRoomScreen extends StatefulWidget {
  const ClassRoomScreen({
    super.key,
  });

  @override
  State<ClassRoomScreen> createState() => _ClassRoomScreenState();
}

class _ClassRoomScreenState extends State<ClassRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final tS = MediaQuery.of(context).textScaleFactor;
    final dW = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(
          text: "Classroom",
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
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: dW * 0.025),
          padding: EdgeInsets.symmetric(horizontal: dW * 0.05),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LectureScreen(
                        classRoom: "History",
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  width: double.infinity,
                  padding: EdgeInsets.all(dW * 0.05),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '#526',
                        tS: tS,
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      SizedBox(
                        height: dW * 0.015,
                      ),
                      CustomText(
                        text: "History",
                        tS: tS,
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: dW * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: dW * 0.05, vertical: dW * 0.01),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: whiteColor),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "View",
                                  tS: tS,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: primaryColor,
                                  size: 12.5,
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.person,
                                  color: whiteColor,
                                  size: 14,
                                ),
                              ),
                              SizedBox(
                                width: dW * 0.01,
                              ),
                              CustomText(
                                text: "+20",
                                tS: tS,
                                color: whiteColor,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: CustomText(
          text: 'Create Classroom',
          tS: tS,
          color: Colors.white,
        ),
        icon: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0))),
              context: context,
              builder: (context) => const CreateClassRoom()).then((value) {
            if (value != null && value != '') {}
          });
        },
      ),
    );
  }
}
