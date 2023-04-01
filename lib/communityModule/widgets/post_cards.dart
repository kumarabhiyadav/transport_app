// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../../common_widgets.dart';

class PostCard extends StatelessWidget {
  final post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final tS = MediaQuery.of(context).textScaleFactor;
    final dW = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dW * 0.05),
      padding: EdgeInsets.symmetric(horizontal: dW * 0.02, vertical: dW * 0.03),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor.withOpacity(0.6), width: 0.5),
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
              const CircleAvatar(
                child: Icon(Icons.person),
              ),
              SizedBox(
                width: dW * 0.02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: post['user']['name'],
                    tS: tS,
                    fontSize: 14,
                  ),
                  CustomText(
                    text: DateFormat('dd MMM yyyy h:m a')
                        .format(DateTime.parse(post['createdAt']).toLocal()),
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
          if (post['title'] != "")
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: dW * 0.75,
                    child: CustomText(
                      text: post['title'],
                      tS: tS,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: post['photo'] != null
                    ? SizedBox(
                        width: dW * 0.7,
                        height: dW * 0.4,
                        child: Image.network(
                          post['photo'],
                          fit: BoxFit.fill,
                        ),
                      )
                    : null,
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
                post['liked']
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.red,
                      ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: dW * 0.01),
                    child: CustomText(
                        text: post['likeCounts'].toString(), tS: tS)),
                SizedBox(
                  width: dW * 0.04,
                ),
                const Icon(
                  Icons.comment,
                  color: primaryColor,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: dW * 0.01),
                    child: CustomText(
                        text: post['likeCounts'].toString(), tS: tS)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
