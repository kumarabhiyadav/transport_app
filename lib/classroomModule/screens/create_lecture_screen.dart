import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../colors.dart';
import '../../common_widgets.dart';

class CreateLecture extends StatefulWidget {
  const CreateLecture({super.key});

  @override
  State<CreateLecture> createState() => _CreateLectureState();
}

class _CreateLectureState extends State<CreateLecture> {
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  File? file;

  @override
  Widget build(BuildContext context) {
    final tS = MediaQuery.of(context).textScaleFactor;
    final dW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Create new Lecture",
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: dW * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: dW * 0.05,
            ),
            TextFormField(
              style: GoogleFonts.lato(
                  fontSize: tS * 18,
                  letterSpacing: .86,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              decoration: textformFeildDecoration('Enter lecture title', null),
            ),
            SizedBox(
              height: dW * 0.05,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1));
              },
              child: TextFormField(
                enabled: false,
                style: GoogleFonts.lato(
                    fontSize: tS * 18,
                    letterSpacing: .86,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                decoration: textformFeildDecoration('Select Date', null),
              ),
            ),
            SizedBox(
              height: dW * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      if (value != null) {
                        startTime = value;
                      }
                    });
                  },
                  child: SizedBox(
                    width: dW * 0.4,
                    child: TextFormField(
                      enabled: false,
                      style: GoogleFonts.lato(
                          fontSize: tS * 18,
                          letterSpacing: .86,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: textformFeildDecoration('Start Time', null),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      if (value != null) {
                        startTime = value;
                      }
                    });
                  },
                  child: SizedBox(
                    width: dW * 0.4,
                    child: TextFormField(
                      enabled: false,
                      style: GoogleFonts.lato(
                          fontSize: tS * 18,
                          letterSpacing: .86,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      decoration: textformFeildDecoration('End Time', null),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: dW * 0.05,
            ),
            GestureDetector(
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  File uploadFile = File(result.files.single.path!);
                  print(result.files.single.path);

                  setState(() {
                    file = uploadFile;
                  });
                } else {
                  // User canceled the picker
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.upload_file,
                    color: primaryColor,
                  ),
                  SizedBox(
                    width: dW * 0.02,
                  ),
                  CustomText(
                    text: "Upload File",
                    tS: tS,
                  ),
                ],
              ),
            ),
            if (file != null)
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: dW * 0.02, vertical: dW * 0.01),
                margin: EdgeInsets.symmetric(vertical: dW * 0.05),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: file!.path
                            .split('/')[file!.path.split('/').length - 1],
                        tS: tS),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            file = null;
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ))
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
