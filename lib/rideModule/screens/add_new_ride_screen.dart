// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';
import 'package:transport_app/rideModule/provider/ride_provider.dart';

import '../../colors.dart';
import '../../common_widgets.dart';

class AddNewRideScreen extends StatefulWidget {
  final String from;
  final Map<String, String>? sourceAndDestination;
  const AddNewRideScreen(
      {super.key, required this.from, this.sourceAndDestination});

  @override
  State<AddNewRideScreen> createState() => _AddNewRideScreenState();
}

class _AddNewRideScreenState extends State<AddNewRideScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController customerController = TextEditingController();

  TextEditingController truckNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController lrNoController = TextEditingController();
  TextEditingController particularController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController detentionController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  DateTime? date;

  List<Ride> rides = [];

  save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      Ride ride = Ride(
          id: '',
          customer: customerController.text,
          date: date!,
          detention: detentionController.text == ""
              ? 0.0
              : double.parse(detentionController.text),
          lrNo: lrNoController.text,
          particular: particularController.text,
          quantity: double.parse(quantityController.text),
          rate: double.parse(rateController.text),
          truckNumber: truckNumberController.text,
          source: widget.sourceAndDestination != null
              ? widget.sourceAndDestination!['source']
              : sourceController.text,
          destination: widget.sourceAndDestination != null
              ? widget.sourceAndDestination!['destination']
              : destinationController.text);

      // This block is for avoid entering data to db when new rides are create from create invoice page
      if (widget.sourceAndDestination == null) {
        final result = await Provider.of<RideProvider>(context, listen: false)
            .createRide(ride);

        if (result) {
          rides.add(ride);
          Navigator.pop(context, rides);
        } else {
          print("Error");
        }
      } else {
        Navigator.pop(context, rides);
        // Reverse Condition
      }
    }
  }

  saveAndNew() {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      Ride ride = Ride(
          id: '',
          customer: customerController.text,
          date: date!,
          detention: detentionController.text == ""
              ? 0.0
              : double.parse(detentionController.text),
          lrNo: lrNoController.text,
          particular: particularController.text,
          quantity: double.parse(quantityController.text),
          rate: double.parse(rateController.text),
          truckNumber: truckNumberController.text);

      rides.add(ride);

      setState(() {
        truckNumberController.text = '';
        dateController.text = '';
        lrNoController.text = '';
        particularController.text = '';
        quantityController.text = '';
        rateController.text = '';
        detentionController.text = '';
        sourceController.text = '';
        destinationController.text = '';
        date = null;
      });
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
              Navigator.pop(context, rides);
            },
            child: const Icon(Icons.arrow_back)),
        backgroundColor: primaryColor,
        title: const Text("Add New Ride"),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Container(
                  margin: EdgeInsets.only(
                      top: dW * 0.04,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  padding: EdgeInsets.symmetric(horizontal: dW * 0.025),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(dW * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.from == "ridesScreen")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Customer Name *",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: tS * 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextFormField(
                                  controller: customerController,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: tS * 20),
                                  cursorHeight: 25,
                                  decoration: textformFeildDecoration(
                                      'Start typing and select Truck', null),
                                  validator: ((value) {
                                    if (value!.trim() == '') {
                                      return 'Please Choose Truck Number';
                                    }
                                    return null;
                                  }),
                                ),
                                SizedBox(
                                  height: dW * 0.05,
                                ),
                              ],
                            ),
                          Text(
                            "Truck Number *",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: tS * 16,
                                fontWeight: FontWeight.w400),
                          ),
                          TextFormField(
                            controller: truckNumberController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                                color: Colors.black, fontSize: tS * 20),
                            cursorHeight: 25,
                            decoration: textformFeildDecoration(
                                'Start typing and select Truck', null),
                            validator: ((value) {
                              if (value!.trim() == '') {
                                return 'Please Choose Truck Number';
                              }
                              return null;
                            }),
                          ),
                          SizedBox(
                            height: dW * 0.05,
                          ),
                          Text(
                            "LR No*",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: tS * 16,
                                fontWeight: FontWeight.w400),
                          ),
                          TextFormField(
                            controller: lrNoController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                                color: Colors.black, fontSize: tS * 20),
                            cursorHeight: 25,
                            decoration: textformFeildDecoration('12345', null),
                            validator: ((value) {
                              if (value!.trim() == '') {
                                return 'Please enter LR No.';
                              }
                              return null;
                            }),
                          ),
                          SizedBox(
                            height: dW * 0.05,
                          ),
                          Text(
                            "Date *",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: tS * 16,
                                fontWeight: FontWeight.w400),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate:
                                          DateTime(DateTime.now().year + 2))
                                  .then((value) {
                                if (value != null) {
                                  date = value;
                                  setState(() {
                                    dateController.text =
                                        DateFormat('dd MMM yyyy').format(date!);
                                  });
                                }
                              });
                            },
                            child: TextFormField(
                              validator: ((value) {
                                if (value!.trim() == '') {
                                  return 'Please Choose date';
                                }
                                return null;
                              }),
                              enabled: false,
                              controller: dateController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                  color: Colors.black, fontSize: tS * 20),
                              cursorHeight: 25,
                              decoration: textformFeildDecoration(
                                  'Select Date', Icons.calendar_month),
                            ),
                          ),
                          SizedBox(
                            height: dW * 0.05,
                          ),
                          Text(
                            "Particulars *",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: tS * 16,
                                fontWeight: FontWeight.w400),
                          ),
                          TextFormField(
                              validator: ((value) {
                                if (value!.trim() == '') {
                                  return 'Please enter particular';
                                }
                                return null;
                              }),
                              controller: particularController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                  color: Colors.black, fontSize: tS * 20),
                              cursorHeight: 25,
                              decoration: textformFeildDecoration(
                                  'Start typing and select location', null)),
                          SizedBox(
                            height: dW * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quantity *",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: tS * 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: dW * 0.4,
                                child: Text(
                                  "Rate *",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: tS * 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: dW * 0.4,
                                child: TextFormField(
                                  validator: ((value) {
                                    if (value!.trim() == '') {
                                      return 'Please enter quantity';
                                    }
                                    return null;
                                  }),
                                  controller: quantityController,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: tS * 20),
                                  cursorHeight: 25,
                                  decoration:
                                      textformFeildDecoration('kg', null),
                                ),
                              ),
                              SizedBox(
                                width: dW * 0.4,
                                child: TextFormField(
                                    validator: ((value) {
                                      if (value!.trim() == '') {
                                        return 'Please enter rate';
                                      }
                                      return null;
                                    }),
                                    controller: rateController,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: tS * 20),
                                    cursorHeight: 25,
                                    decoration: textformFeildDecoration(
                                        '\u{20B9}', null)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: dW * 0.05,
                          ),
                          Text(
                            "Detention *",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: tS * 16,
                                fontWeight: FontWeight.w400),
                          ),
                          TextFormField(
                              controller: detentionController,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                  color: Colors.black, fontSize: tS * 20),
                              cursorHeight: 25,
                              decoration:
                                  textformFeildDecoration('\u{20B9}', null)),
                          if (widget.from == 'ridesScreen')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: dW * 0.05,
                                ),
                                Text(
                                  "From",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: tS * 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextFormField(
                                    controller: sourceController,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: tS * 20),
                                    cursorHeight: 25,
                                    decoration: textformFeildDecoration(
                                        '\u{20B9}', null)),
                                SizedBox(
                                  height: dW * 0.05,
                                ),
                                Text(
                                  "To",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: tS * 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextFormField(
                                    controller: destinationController,
                                    textInputAction: TextInputAction.next,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: tS * 20),
                                    cursorHeight: 25,
                                    decoration: textformFeildDecoration(
                                        '\u{20B9}', null)),
                              ],
                            )
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
                      saveAndNew();
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
      ),
      // resizeToAvoidBottomInset: false,
    );
  }
}
