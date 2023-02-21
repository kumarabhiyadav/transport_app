// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/customerModule/provider/customer_provider.dart';

import '../../colors.dart';
import '../../common_widgets.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  save() async {
    final response = await Provider.of<CustomerProvider>(context, listen: false)
        .createCustomer(body: {
      "companyName": companyNameController.text,
      "customerName": customerNameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "address": addressController.text
    });

    if (response != null) {
      Navigator.pop(context);
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        backgroundColor: primaryColor,
        title: const Text("Add New Customer"),
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    top: dW * 0.05,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                padding: EdgeInsets.symmetric(horizontal: dW * 0.025),
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.all(dW * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Customer Name *",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: tS * 16,
                              fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: customerNameController,
                          textInputAction: TextInputAction.next,
                          style:
                              TextStyle(color: Colors.black, fontSize: tS * 20),
                          cursorHeight: 25,
                          decoration: textformFeildDecoration(
                              'Enter Customer Name', null),
                          validator: ((value) {
                            if (value!.trim() == '') {
                              return 'Please enter customer Name';
                            }
                            return null;
                          }),
                        ),
                        SizedBox(
                          height: dW * 0.05,
                        ),
                        Text(
                          "Company Name*",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: tS * 16,
                              fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: companyNameController,
                          textInputAction: TextInputAction.next,
                          style:
                              TextStyle(color: Colors.black, fontSize: tS * 20),
                          cursorHeight: 25,
                          decoration: textformFeildDecoration(
                              'Enter Company Name', null),
                          validator: ((value) {
                            if (value!.trim() == '') {
                              return 'Please enter Company Name';
                            }
                            return null;
                          }),
                        ),
                        SizedBox(
                          height: dW * 0.05,
                        ),
                        Text(
                          "Company Address *",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: tS * 16,
                              fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: addressController,
                          textInputAction: TextInputAction.next,
                          style:
                              TextStyle(color: Colors.black, fontSize: tS * 20),
                          cursorHeight: 25,
                          decoration: textformFeildDecoration(
                              'Enter Company Address', null),
                          validator: ((value) {
                            if (value!.trim() == '') {
                              return 'Please enter Company Address';
                            }
                            return null;
                          }),
                        ),
                        SizedBox(
                          height: dW * 0.05,
                        ),
                        Text(
                          "Phone Number *",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: tS * 16,
                              fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: phoneController,
                          textInputAction: TextInputAction.next,
                          style:
                              TextStyle(color: Colors.black, fontSize: tS * 20),
                          cursorHeight: 25,
                          decoration: textformFeildDecoration(
                              'Enter Phone Number', null),
                          validator: ((value) {
                            if (value!.trim() == '') {
                              return 'Please enter Phone Number';
                            }
                            return null;
                          }),
                        ),
                        SizedBox(
                          height: dW * 0.05,
                        ),
                        Text(
                          "E-mail *",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: tS * 16,
                              fontWeight: FontWeight.w400),
                        ),
                        TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          style:
                              TextStyle(color: Colors.black, fontSize: tS * 20),
                          cursorHeight: 25,
                          decoration:
                              textformFeildDecoration('Enter Email', null),
                          validator: ((value) {
                            if (value!.trim() == '') {
                              return 'Please enter email';
                            }
                            return null;
                          }),
                        ),
                        SizedBox(
                          height: dW * 0.05,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.01),
                  spreadRadius: 0.4,
                  blurRadius: .07,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(
                horizontal: dW * 0.05, vertical: dW * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: dW * 0.04, horizontal: dW * 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                      side: const BorderSide(
                          color: primaryColor,
                          width: 10,
                          style: BorderStyle.solid),
                    ),
                  ),
                  onPressed: () {
                    // saveAndNew();
                  },
                  child: Text(
                    'Save and New',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: tS * 16),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(
                        vertical: dW * 0.04, horizontal: dW * 0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: () {
                    save();
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: tS * 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
