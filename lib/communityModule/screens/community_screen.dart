import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/colors.dart';
import 'package:transport_app/common_widgets.dart';
import 'package:intl/intl.dart';
import 'package:transport_app/communityModule/provider/community_provider.dart';
import 'package:transport_app/communityModule/screens/create_post_screen.dart';
import 'package:transport_app/communityModule/screens/post_detail_screen.dart';
import 'package:transport_app/communityModule/widgets/post_cards.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isLoading = false;
  myInit() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<CommunityProvider>(context, listen: false)
        .fetchPosts("token");

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    myInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tS = MediaQuery.of(context).textScaleFactor;
    final dW = MediaQuery.of(context).size.width;
    final posts = Provider.of<CommunityProvider>(context).listOfPosts;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Social House",
          tS: tS,
          fontSize: 18,
        ),
        backgroundColor: Colors.white,
        leading: null,
        elevation: 0,
      ),
      body: SafeArea(
          child: isLoading
              ? const SpinKitFadingCube(
                  color: primaryColor,
                )
              : posts.isEmpty
                  ? Center(
                      child: CustomText(tS: tS, text: "No Post"),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: dW * 0.05),
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostDetailScreen(
                                        post: posts[index],
                                      ))),
                          child: PostCard(post: posts[index])),
                      itemCount: posts.length,
                    )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatePostScreen()))
              .then((value) {
            myInit();
          });
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
