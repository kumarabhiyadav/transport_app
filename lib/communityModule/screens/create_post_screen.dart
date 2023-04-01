// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/colors.dart';
import 'package:transport_app/common_widgets.dart';
import 'package:transport_app/communityModule/provider/community_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      print(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  createNewPost() async {
    if (_formKey.currentState!.validate() || image != null) {
      setState(() {
        isLoading = true;
      });
      final response =
          await Provider.of<CommunityProvider>(context, listen: false)
              .createNewPost({
        'title': titleController.text,
        'user': '6426ea023dd6023a1d692a4f'
      }, image == null ? '' : image!.path, "");

      if (response['success']) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tS = MediaQuery.of(context).textScaleFactor;
    final dW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: primaryColor,
            )),
        elevation: 0,
        backgroundColor: whiteColor,
        title: CustomText(
          text: "Create Post",
          tS: tS,
          fontSize: 16,
        ),
      ),
      body: isLoading
          ? const SpinKitFadingCube(
              color: primaryColor,
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: dW * 0.05),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleController,
                      validator: (value) {
                        // if (value!.isEmpty) {
                        //   return 'Please enter title';
                        // }
                      },
                      minLines: 2,
                      maxLines: 4,
                      style: GoogleFonts.lato(
                          fontSize: tS * 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: dW * 0.12,
                    ),
                    GestureDetector(
                      onTap: () => pickImage(),
                      child: Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.all(dW * 0.15),
                        height: dW * 0.5,
                        width: dW * 0.4,

                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: image != null
                            ? Image.file(File(image!.path))
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.camera_alt_rounded),
                                  CustomText(
                                    text: "Upload a photo",
                                    tS: tS,
                                    fontSize: 12,
                                  )
                                ],
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: isLoading
          ? null
          : GestureDetector(
              onTap: () {
                createNewPost();
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: dW * 0.01, horizontal: dW * 0.05),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
