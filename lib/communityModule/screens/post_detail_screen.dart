// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/common_widgets.dart';

import '../../colors.dart';
import '../provider/community_provider.dart';

class PostDetailScreen extends StatefulWidget {
  final post;
  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool isLoading = false;
  TextEditingController commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  myInit() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<CommunityProvider>(context, listen: false)
        .fetchComment(body: {
      'post': widget.post["_id"],
    }, token: "");
    setState(() {
      isLoading = false;
    });
  }

  createComment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final response =
          await Provider.of<CommunityProvider>(context, listen: false)
              .createComment(body: {
        'comment': commentController.text,
        'user': '6426ea023dd6023a1d692a4f',
        'post': widget.post["_id"],
      }, token: "");

      if (response['success']) {
        setState(() {
          isLoading = false;
          commentController.text = "";
        });
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    myInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    final comments = Provider.of<CommunityProvider>(context).comments;

    return Scaffold(
      body: isLoading
          ? const SpinKitFadingCube(
              color: primaryColor,
            )
          : SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(dW * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: widget.post['title'], tS: tS),
                    widget.post['photo'] != null
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: dW * 0.05),
                            height: dW * 0.4,
                            width: dW,
                            child: Image.network(
                              widget.post['photo'],
                              fit: BoxFit.fill,
                            ),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: dW * 0.05,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.favorite_border),
                        SizedBox(
                          width: dW * 0.05,
                        ),
                        const Icon(Icons.comment)
                      ],
                    ),
                    SizedBox(
                      height: dW * 0.1,
                    ),
                    ...comments.map((e) => Container(
                          margin: EdgeInsets.only(bottom: dW * 0.05),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              SizedBox(
                                width: dW * 0.02,
                              ),
                              SizedBox(
                                width: dW * 0.75,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: e['user']['name'],
                                      tS: tS,
                                      fontSize: 14,
                                    ),
                                    CustomText(
                                      text: e['comment'],
                                      tS: tS,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
      floatingActionButton: isLoading
          ? null
          : Container(
              margin: EdgeInsets.symmetric(horizontal: dW * 0.05),
              child: Form(
                key: _formKey,
                child: TextFormField(
                    controller: commentController,
                    style: GoogleFonts.lato(
                        fontSize: tS * 16,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    decoration: textformFeildDecoration(
                        'Write Comment',
                        IconButton(
                            onPressed: () {
                              createComment();
                            },
                            icon: const Icon(Icons.send_rounded)))),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
