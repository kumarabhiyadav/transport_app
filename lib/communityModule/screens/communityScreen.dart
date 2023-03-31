import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transport_app/colors.dart';
import 'package:transport_app/common_widgets.dart';
import 'package:intl/intl.dart';
import 'package:transport_app/communityModule/screens/create_post_screen.dart';
import 'package:transport_app/communityModule/widgets/post_cards.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    final tS = MediaQuery.of(context).textScaleFactor;
    final dW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: dW * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: dW * 0.05,
            ),
            CustomText(
              text: "Social",
              tS: tS,
              fontSize: 20,
            ),
            SizedBox(
              height: dW * 0.04,
            ),
            PostCard()
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePostScreen()));
        },
        icon: const Icon(
          Icons.add,
          size: 18,
        ),
        label: CustomText(
          text: "New Post",
          tS: tS,
          color: whiteColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
