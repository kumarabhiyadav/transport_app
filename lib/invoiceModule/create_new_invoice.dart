// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:transport_app/common_widgets.dart';
import 'package:transport_app/rideModule/add_new_ride_screen.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';

import '../colors.dart';

class CreateNewInvoice extends StatefulWidget {
  const CreateNewInvoice({super.key});

  @override
  State<CreateNewInvoice> createState() => _CreateNewInvoiceState();
}

class _CreateNewInvoiceState extends State<CreateNewInvoice> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  DateTime? date;

  List<Ride> rides = [];

  double getTotal() {
    double total = 0.0;
    for (var ride in rides) {
      total += (ride.quantity * ride.rate) + ride.detention!;
    }
    return total;
  }

  save() {}
  viewInvoice() {}
  openPDF() {}

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("New Invoice"),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.preview)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(dW * 0.025),
          width: dW,
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(dW * 0.05),
                  child: Column(
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
                        controller: customerNameController,
                        style:
                            TextStyle(color: Colors.black, fontSize: tS * 20),
                        cursorHeight: 28,
                        decoration: textformFeildDecoration(
                            'Start typing and select Customer...', null),
                      ),
                      SizedBox(
                        height: dW * 0.05,
                      ),
                      Text(
                        "Invoice #*",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: tS * 16,
                            fontWeight: FontWeight.w400),
                      ),
                      TextFormField(
                        controller: invoiceNumberController,
                        style:
                            TextStyle(color: Colors.black, fontSize: tS * 20),
                        cursorHeight: 28,
                        decoration: textformFeildDecoration('INV-000002', null),
                      ),
                      SizedBox(
                        height: dW * 0.05,
                      ),
                      Text(
                        "Invoice Date *",
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
                                  lastDate: DateTime(DateTime.now().year + 2))
                              .then((value) {
                            if (value != null) {
                              date = value;
                              dateController.text =
                                  DateFormat('dd MMM yyyy').format(date!);
                            }
                          });
                        },
                        child: TextFormField(
                          enabled: false,
                          controller: dateController,
                          style:
                              TextStyle(color: Colors.black, fontSize: tS * 20),
                          cursorHeight: 28,
                          decoration: textformFeildDecoration(
                              'Date', Icons.calendar_month),
                        ),
                      ),
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
                        controller: fromController,
                        style:
                            TextStyle(color: Colors.black, fontSize: tS * 20),
                        cursorHeight: 28,
                        decoration: textformFeildDecoration(
                            'Start typing and select location', null),
                      ),
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
                        controller: toController,
                        style:
                            TextStyle(color: Colors.black, fontSize: tS * 20),
                        cursorHeight: 28,
                        decoration: textformFeildDecoration(
                            'Start typing and select location', null),
                      ),
                      SizedBox(
                        height: dW * 0.05,
                      ),
                      Text(
                        "Advance",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: tS * 16,
                            fontWeight: FontWeight.w400),
                      ),
                      TextFormField(
                          controller: advanceController,
                          style:
                              TextStyle(color: Colors.black, fontSize: tS * 20),
                          cursorHeight: 28,
                          decoration: textformFeildDecoration('\u{20B9}', null))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: dH * 0.01,
              ),
              Card(
                elevation: 2,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.all(dW * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: dW * 0.32, vertical: dW * 0.025),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2))),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddNewRideScreen(),
                                        )).then((value) {
                                      print(value);

                                      if (value != null) {
                                        setState(() {
                                          rides.addAll(value);
                                        });
                                      }
                                      Navigator.pop(context);
                                    });
                                  },
                                  leading: const Icon(
                                    Icons.add,
                                    color: primaryColor,
                                  ),
                                  title: const Text('Create New Ride'),
                                  minLeadingWidth: 10,
                                ),
                                ListTile(
                                  onTap: () {},
                                  leading: const Icon(
                                    Icons.person,
                                    color: primaryColor,
                                  ),
                                  title:
                                      const Text('Select from Customers Ride'),
                                  minLeadingWidth: 10,
                                ),
                              ],
                            ),
                          );

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AddNewRideScreen()));
                        },
                        icon: const CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 12,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        label: Text(
                          'Add Ride',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: tS * 15),
                        ),
                      ),

                      // Selected Rides

                      if (rides.isNotEmpty)
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: dW * 0.04, bottom: dW * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rides',
                                    style: TextStyle(
                                        fontSize: tS * 16,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                        letterSpacing: .67),
                                  ),
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontSize: tS * 16,
                                        fontWeight: FontWeight.w500,
                                        color: primaryColor,
                                        letterSpacing: .67),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            ...rides.asMap().entries.map((e) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: dW * 0.05,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  rides.removeAt(e.key);
                                                });
                                              },
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.red)),
                                                child: const Icon(
                                                  Icons.clear,
                                                  size: 18,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: dW * 0.04,
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: dW * 0.55,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              e.value.truckNumber,
                                              style: TextStyle(
                                                  fontSize: tS * 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            height: dW * 0.01,
                                          ),
                                          SizedBox(
                                            width: dW * 0.55,
                                            child: Text(
                                              "[${e.value.quantity} X ${e.value.rate}] + ${e.value.detention}",
                                              style: TextStyle(
                                                  fontSize: tS * 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topRight,
                                            width: dW * 0.238,
                                            child: FittedBox(
                                              child: Text(
                                                ((e.value.quantity *
                                                            e.value.rate) +
                                                        e.value.detention!)
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: tS * 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              );
                            }),
                            Container(
                              margin: EdgeInsets.only(top: dW * 0.02),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox.shrink(),
                                  Text(
                                    "Total(\u{20B9})",
                                    style: TextStyle(
                                        fontSize: tS * 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  FittedBox(
                                    child: SizedBox(
                                      width: dW * 0.238,
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        getTotal().toStringAsFixed(2),
                                        style: TextStyle(
                                            fontSize: tS * 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
