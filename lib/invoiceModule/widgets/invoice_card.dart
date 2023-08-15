import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transport_app/invoiceModule/models/invoice.dart';

import '../../colors.dart';
import '../templates/vishal_template.dart';

class InvoiceCard extends StatefulWidget {
  final Invoice invoice;
  const InvoiceCard({super.key, required this.invoice});

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  bool showRides = false;

  generatePDF() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;

    final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        getBill(widget.invoice), targetPath, "111");

    // print(generatedPdfFile.path);

    try {
      await OpenFile.open(generatedPdfFile.path);
    } catch (e) {
      // print(e);
    }

    return generatedPdfFile.path;
  }

  newPdf()async{
final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
         children: [

          pw.Row(
            children: [
              pw.Text('Vishal Roadlines')
            ]
          ),
          pw.Text("Vishal RoadLines"),

         ]
      ),
    ),
  );







    // File IO for PDF
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(await pdf.save()); 
    await OpenFile.open(file.path);  
   



  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(dW * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "INVOICE :#${widget.invoice.invoiceNo}",
                  style: TextStyle(
                      fontSize: tS * 14,
                      color: blueColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .10),
                ),
                PopupMenuButton(
                    onSelected: ((value) {
                      switch (value) {
                        case 1:
                          //Delete
                          break;

                        case 2:
                          //hide
                          break;

                        case 3:
                          // generatePDF();
                          newPdf();
                          break;

                        case 4:
                          //Share
                          break;
                      }
                    }),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: TextButton.icon(
                              onPressed: null,
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              label: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: TextButton.icon(
                              onPressed: null,
                              icon: const Icon(
                                Icons.archive,
                                color: Colors.grey,
                              ),
                              label: const Text(
                                'Archive',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: TextButton.icon(
                              onPressed: null,
                              icon: const Icon(
                                Icons.picture_as_pdf_rounded,
                                color: Colors.grey,
                              ),
                              label: const Text(
                                'View PDF',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 3,
                            child: TextButton.icon(
                              onPressed: null,
                              icon: const Icon(
                                Icons.share_rounded,
                                color: Colors.blue,
                              ),
                              label: const Text(
                                'Share',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ]),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Source",
                  style: TextStyle(
                      fontSize: tS * 16,
                      color: blueColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .10),
                ),
                Text(
                  "Destination",
                  style: TextStyle(
                      fontSize: tS * 16,
                      color: blueColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .10),
                ),
              ],
            ),
            const Divider(
              color: Colors.transparent,
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.invoice.source,
                  style: TextStyle(
                      fontSize: tS * 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .56),
                ),
                Text(
                  widget.invoice.destination,
                  style: TextStyle(
                      fontSize: tS * 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .56),
                ),
              ],
            ),
            const Divider(),
            Text(
              "Company Name",
              style: TextStyle(
                  fontSize: tS * 16,
                  color: blueColor,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .10),
            ),
            const Divider(
              color: Colors.transparent,
              height: 2,
            ),
            Text(
              widget.invoice.customer.companyName.toUpperCase(),
              style: TextStyle(
                  fontSize: tS * 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .56),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                setState(() {
                  showRides = !showRides;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rides',
                        style: TextStyle(
                            fontSize: tS * 16,
                            color: blueColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: .10),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        showRides = !showRides;
                      });
                    },
                    icon: Transform.rotate(
                      angle: showRides ? pi : pi * 2,
                      child: const Icon(
                        Icons.arrow_downward_rounded,
                        color: blueColor,
                      ),
                    ),
                    label: Text(
                      widget.invoice.rides.length.toString(),
                      style: TextStyle(
                        fontSize: tS * 16,
                        color: blueColor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .10,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.invoice.rides
                    .map(
                      (ride) => AnimatedContainer(
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(milliseconds: 300),
                        height: showRides ? (dW * .45) : 0.0,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: SizedBox(
                            height: dW * .45,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             const   Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Text(
                                      "Truck Number",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ride.truckNumber,
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: tS * 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .56),
                                    ),
                                    Text(
                                      DateFormat('dd MMM yyyy')
                                          .format(ride.date.toLocal()),
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: tS * 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .56),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 6,
                                ),
                            const    Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Text(
                                      "LR No.",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Particular",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ride.lrNo,
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: tS * 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .56),
                                    ),
                                    Text(
                                      ride.particular,
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: tS * 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .56),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 6,
                                ),
                             const   Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Text(
                                      "Quantity",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Rate",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ride.quantity.toString(),
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: tS * 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .56),
                                    ),
                                    Text(
                                      ride.rate.toString(),
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: tS * 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .56),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.transparent,
                                  height: 6,
                                ),
                              const  Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:  [
                                    Text(
                                      "Detention",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Ride Total",
                                      style: TextStyle(
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ride.detention.toString(),
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: tS * 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .56),
                                    ),
                                    Text(
                                      ((ride.quantity * ride.rate) +
                                              ride.detention!)
                                          .toStringAsFixed(2),
                                      style: TextStyle(
                                          color: blueColor,
                                          fontSize: tS * 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: .56),
                                    ),
                                  ],
                                ),
                                const Divider()
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
            if (!showRides) const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Advance",
                  style: TextStyle(
                      fontSize: tS * 16,
                      color: blueColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .10),
                ),
                Text(
                  "Total Amount",
                  style: TextStyle(
                      fontSize: tS * 16,
                      color: blueColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .10),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\u{20B9} ${widget.invoice.advance.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: tS * 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .56),
                ),
                Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  '\u{20B9}' +
                      (widget.invoice.total - widget.invoice.advance)
                          .toStringAsFixed(2),
                  style: TextStyle(
                      fontSize: tS * 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
