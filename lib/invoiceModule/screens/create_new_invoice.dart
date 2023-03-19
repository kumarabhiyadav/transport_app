import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:textfield_search/textfield_search.dart';

import 'package:transport_app/common_widgets.dart';
import 'package:transport_app/customerModule/model/customer.dart';
import 'package:transport_app/customerModule/provider/customer_provider.dart';
import 'package:transport_app/invoiceModule/models/invoice.dart';
import 'package:transport_app/invoiceModule/provider/invoice_provider.dart';
import 'package:transport_app/invoiceModule/templates/vishal_template.dart';
import 'package:transport_app/rideModule/screens/add_new_ride_screen.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';

import '../../colors.dart';

class CreateNewInvoice extends StatefulWidget {
  const CreateNewInvoice({super.key});

  @override
  State<CreateNewInvoice> createState() => _CreateNewInvoiceState();
}

class _CreateNewInvoiceState extends State<CreateNewInvoice> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController advanceController = TextEditingController();
  DateTime? date;
  Customer? customer;
  List<Customer> customerSuggestions = [];
  bool showCustomerSuggestion = false;

  List<Ride> rides = [];

  double getTotal() {
    double total = 0.0;
    for (var ride in rides) {
      total += (ride.quantity * ride.rate) + ride.detention!;
    }
    return total;
  }

  notValidate() => !_formKey.currentState!.validate();

  save() async {
    if (notValidate()) {
      return;
    } else {
      // generatePDF();

      setState(() {
        isLoading = true;
      });
      final Invoice currentInvoice = Invoice(
          advance: double.parse(advanceController.text),
          customer: customer!,
          date: date!,
          destination: toController.text,
          id: '',
          invoiceNo: invoiceNumberController.text,
          rides: rides,
          total: getTotal(),
          source: fromController.text);
      await Provider.of<InvoiceProvider>(context, listen: false)
          .createInvoice(currentInvoice);

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      setState(() {
        isLoading = false;
      });
    }
  }

  printFunction() {
    if (notValidate()) {
      return;
    } else {
      generatePDF();
    }
  }

  generatePDF() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        "", targetPath, invoiceNumberController.text);

    // print(generatedPdfFile.path);

    try {
      await OpenFile.open(generatedPdfFile.path);
    } catch (e) {
      // print(e);
    }

    return generatedPdfFile.path;
  }

  final _debouncer = Debouncer(milliseconds: 500);

  searchCustomer(query) async {
    customerSuggestions = [];
    final results = await Provider.of<CustomerProvider>(context, listen: false)
        .searchCustomer(query);
    customerSuggestions.addAll(results);
    setState(() {});
  }

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
          IconButton(onPressed: () => save(), icon: const Icon(Icons.save)),
          IconButton(
              onPressed: () => printFunction(), icon: const Icon(Icons.print)),
        ],
      ),
      body: isLoading
          ? const SpinKitFadingCube(
              color: primaryColor,
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.all(dW * 0.025),
                width: dW,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.hardEdge,
                        fit: StackFit.passthrough,
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
                                    validator: ((value) {
                                      if (value!.trim() == '') {
                                        return 'Please Choose Customer';
                                      }
                                      return null;
                                    }),
                                    onChanged: ((val) {
                                      setState(() {
                                        showCustomerSuggestion = true;
                                      });
                                      _debouncer.run(() {
                                        searchCustomer(val);
                                      });
                                    }),
                                    controller: customerNameController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: tS * 20),
                                    cursorHeight: 28,
                                    decoration: textformFeildDecoration(
                                        'Start typing and select Customer...',
                                        null),
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
                                    validator: ((value) {
                                      if (value!.trim() == '') {
                                        return 'Please enter invoice no';
                                      }
                                      return null;
                                    }),
                                    controller: invoiceNumberController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: tS * 20),
                                    cursorHeight: 28,
                                    decoration: textformFeildDecoration(
                                        'INV-000002', null),
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
                                              lastDate: DateTime(
                                                  DateTime.now().year + 2))
                                          .then((value) {
                                        if (value != null) {
                                          date = value;
                                          dateController.text =
                                              DateFormat('dd MMM yyyy')
                                                  .format(date!);
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
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: tS * 20),
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
                                    validator: ((value) {
                                      if (value!.trim() == '') {
                                        return 'Please select Source';
                                      }
                                      return null;
                                    }),
                                    controller: fromController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: tS * 20),
                                    cursorHeight: 28,
                                    decoration: textformFeildDecoration(
                                        'Start typing and select location',
                                        null),
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
                                    validator: ((value) {
                                      if (value!.trim() == '') {
                                        return 'Please enter destination';
                                      }
                                      return null;
                                    }),
                                    controller: toController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: tS * 20),
                                    cursorHeight: 28,
                                    decoration: textformFeildDecoration(
                                        'Start typing and select location',
                                        null),
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
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: tS * 20),
                                      cursorHeight: 28,
                                      decoration: textformFeildDecoration(
                                          '\u{20B9}', null))
                                ],
                              ),
                            ),
                          ),
                          if (showCustomerSuggestion)
                            Positioned(
                              top: dH * 0.1,
                              left: dW * 0.01,
                              child: Container(
                                width: dW * 0.8,
                                color: Colors.blue.shade50,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...customerSuggestions.map((e) =>
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                customer = e;
                                                customerSuggestions = [];
                                                customerNameController.text =
                                                    customer!.companyName;
                                              });
                                            },
                                            child: Container(
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.white))),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: dW * 0.05,
                                                    horizontal: dW * 0.05),
                                                child: Text(e.companyName)),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ],
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
                                        horizontal: dW * 0.32,
                                        vertical: dW * 0.025),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2))),
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  } else {
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
                                                        AddNewRideScreen(
                                                      from: 'invoice',
                                                      sourceAndDestination: {
                                                        'source':
                                                            fromController.text,
                                                        'destination':
                                                            toController.text
                                                      },
                                                    ),
                                                  )).then((value) {
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
                                            title:
                                                const Text('Create New Ride'),
                                            minLeadingWidth: 10,
                                          ),
                                          ListTile(
                                            onTap: () {},
                                            leading: const Icon(
                                              Icons.person,
                                              color: primaryColor,
                                            ),
                                            title: const Text(
                                                'Select from Customers Ride'),
                                            minLeadingWidth: 10,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
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
                                                        alignment:
                                                            Alignment.topLeft,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .red)),
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      e.value.truckNumber,
                                                      style: TextStyle(
                                                          fontSize: tS * 16,
                                                          fontWeight:
                                                              FontWeight.w500),
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
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    width: dW * 0.238,
                                                    child: FittedBox(
                                                      child: Text(
                                                        ((e.value.quantity *
                                                                    e.value
                                                                        .rate) +
                                                                e.value
                                                                    .detention!)
                                                            .toStringAsFixed(2),
                                                        style: TextStyle(
                                                            fontSize: tS * 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
            ),
    );
  }
}
