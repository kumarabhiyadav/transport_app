import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:transport_app/common_widgets.dart';

import '../../colors.dart';

class CreateClassRoom extends StatefulWidget {
  const CreateClassRoom({super.key});

  @override
  State<CreateClassRoom> createState() => _CreateClassRoomState();
}

class _CreateClassRoomState extends State<CreateClassRoom> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;

    return Container(
      padding: EdgeInsets.only(
        left: dW * 0.05,
        right: dW * 0.05,
        top: dW * 0.05,
        bottom: MediaQuery.of(context).viewInsets.bottom + (dW * 0.01),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'Create Classroom', tS: tS),
          SizedBox(
            height: dW * 0.04,
          ),
          TextFormField(
            controller: nameController,
            decoration: textformFeildDecoration('Enter Title', null),
          ),
          SizedBox(
            height: dW * 0.08,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context, nameController.text);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                color: primaryColor,
              ),
              height: dW * 0.14,
              child: CustomText(
                text: "Create new post",
                tS: tS,
                color: whiteColor,
              ),
            ),
          ),
          SizedBox(
            height: dW * 0.04,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  // color: whiteColor,

                  color: Colors.transparent),
              height: dW * 0.14,
              child: CustomText(
                text: "Cancel",
                tS: tS,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: dW * 0.04,
          ),
        ],
      ),
    );
  }
}
