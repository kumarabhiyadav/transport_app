import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../../common_widgets.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tS = MediaQuery.of(context).textScaleFactor;
    final dW = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dW * 0.02, vertical: dW * 0.03),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        color: whiteColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(
              1.0,
              5.0,
            ),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ), //BoxShadow
          //BoxShadow
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(),
              SizedBox(
                width: dW * 0.02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Abhinav Yadav",
                    tS: tS,
                    fontSize: 14,
                  ),
                  CustomText(
                    text:
                        DateFormat('dd MMM yyyy h:m a').format(DateTime.now()),
                    tS: tS,
                    fontSize: 10,
                  )
                ],
              )
            ],
          ),
          Divider(
            indent: dW * 0.1,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Container(
                  width: dW * 0.8,
                  child: CustomText(
                    text:
                        "This is just a post about a life where we can be add some thing about any thing and life goes on open letter by talha anjum",
                    tS: tS,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            indent: dW * 0.1,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                ),
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                SizedBox(
                  width: dW * 0.04,
                ),
                const Icon(
                  Icons.comment,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
