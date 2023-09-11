import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:indian_currency_to_word/indian_currency_to_word.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transport_app/invoiceModule/models/invoice.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';

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

  newPdf() async {
    final converter = AmountToWords();

    final headers = [
      'Tanker No.',
      'L.R.No.',
      'Date',
      'Quantity',
      'Detention',
      'PARTICULARS',
      'Amount(Rs.)'
    ];
    List<List<String>> data = [];

    for (int i = 0; i <= 30; i++) {
      if (i < widget.invoice.rides.length) {
        Ride ride = widget.invoice.rides[i];
        List<String> temp = [];
        temp.add(ride.truckNumber);
        temp.add(ride.lrNo);
        temp.add(DateFormat('dd-MM-yyyy').format(ride.date));
        temp.add(ride.quantity.toStringAsFixed(2));
        temp.add(ride.detention! < 0 ? '' : ride.detention!.toStringAsFixed(2));
        temp.add(ride.particular.toUpperCase());
        temp.add((ride.quantity * ride.rate).toStringAsFixed(2));
        data.add(temp);
      } else {
        List<String> temp = [];
        temp.add("");
        temp.add("");
        temp.add("");
        temp.add("");
        temp.add("");
        temp.add("");
        temp.add("");
        data.add(temp);
      }
    }

    final tableHeaders = headers.map((header) {
      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        alignment: pw.Alignment.center,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
        ),
        child: pw.Text(header,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      );
    }).toList();

    final tableRows = data.map((row) {
      return row.map((cell) {
        return pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          alignment: pw.Alignment.center,
          decoration: const pw.BoxDecoration(
            border: pw.Border.symmetric(
                vertical: pw.BorderSide(color: PdfColors.black)),
          ),
          child: pw.Text(cell),
        );
      }).toList();
    }).toList();

    final table = pw.Table(
      border: pw.TableBorder.symmetric(
          outside: const pw.BorderSide(color: PdfColors.black)),
      children: [
        pw.TableRow(children: tableHeaders),
        ...tableRows.map((row) => pw.TableRow(children: row)),
      ],
    );

    List<List<String>> amountTableRow = [];
    amountTableRow.add(
        ['Amount', "${widget.invoice.getRideTotal().toStringAsFixed(2)} Rs."]);
    amountTableRow
        .add(['Advance', "${widget.invoice.advance.toStringAsFixed(2)} Rs."]);
    amountTableRow.add([
      'Balance',
      "${(widget.invoice.getRideTotal() - widget.invoice.advance).toStringAsFixed(2)} Rs."
    ]);

    final amountRows = amountTableRow.map((row) {
      return row.map((cell) {
        return pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          alignment: pw.Alignment.centerRight,
          decoration: const pw.BoxDecoration(
            border: pw.Border.symmetric(
                vertical: pw.BorderSide(color: PdfColors.black)),
          ),
          child: pw.Text(cell,
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(fontWeight: pw.FontWeight.normal)),
        );
      }).toList();
    }).toList();

    final amountTable = pw.Table(
        tableWidth: pw.TableWidth.min,
        border: pw.TableBorder.all(),
        children: [
          const pw.TableRow(children: []),
          ...amountRows.map((row) => pw.TableRow(children: row)),
        ]);

    final pdf = pw.Document(pageMode: PdfPageMode.fullscreen);
    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Container(
          width: double.infinity,
          child: pw.Stack(children: [
            pw.Container(
              width: double.infinity,
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisSize: pw.MainAxisSize.max,
                  children: [
                    pw.Text("|| OM SAI ||",
                        style:
                            pw.TextStyle(color: PdfColor.fromHex('#FF0000'))),
                    pw.Text("Subject to Thane Jurisdiction",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Text("VISHAL ROADLINES",
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColor.fromHex('#FF0000'),
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Text('Fleet Owners & Transport Contractor'),
                    pw.Text('Stainless Steel Tanker for Petroleum'),
                    pw.Text('All kind of Oil & Chemical Solvent'),
                    pw.SizedBox(height: 10),
                    pw.Divider(height: 2),
                    pw.Text(
                        'Office :  Ajaykumar Yadav, Kajuwadi, Opp. Shivsena Shakha, Wagle Estate, Thane (W)-400604',
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Text('Email : vishalroadlines1976@gmail.com',
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        )),
                    pw.Divider(height: 2),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('No. ${widget.invoice.invoiceNo}',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Row(children: [
                            pw.Text('Date : '),
                            pw.Text(DateFormat('dd-MM-yyyy')
                                .format(widget.invoice.date))
                          ]),
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                            width: 300,
                            child: pw.RichText(
                              text: pw.TextSpan(
                                  text: 'M/s ',
                                  style: const pw.TextStyle(fontSize: 12),
                                  children: [
                                    pw.TextSpan(
                                        text:
                                            " ${widget.invoice.customer.companyName} ${widget.invoice.customer.address}",
                                        style: pw.TextStyle(
                                            decorationStyle:
                                                pw.TextDecorationStyle.solid,
                                            fontWeight: pw.FontWeight.bold))
                                  ]),
                            ),
                          ),
                          pw.Container(
                              padding: const pw.EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(),
                                  borderRadius: pw.BorderRadius.circular(1)),
                              child: pw.Text('PAN NO. ACGPY 8550 P',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.red)))
                        ]),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      " Being cost of Transporting your products in our tanker as under ",
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text("From : "),
                          pw.Text(" ${widget.invoice.source} ",
                              style: pw.TextStyle(
                                  decoration: pw.TextDecoration.underline,
                                  fontWeight: pw.FontWeight.bold,
                                  letterSpacing: 0.56)),
                          pw.SizedBox(width: 50),
                          pw.Text("To : "),
                          pw.Text(" ${widget.invoice.destination} ",
                              style: pw.TextStyle(
                                  decoration: pw.TextDecoration.underline,
                                  fontWeight: pw.FontWeight.bold,
                                  letterSpacing: 0.56))
                        ]),
                    pw.SizedBox(height: 10),
                    table,
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "Amount (in word) : ",
                                ),
                                pw.Container(
                                  width: 220,
                                  child: pw.Text(
                                      converter.convertAmountToWords(
                                          widget.invoice.getRideTotal() -
                                              widget.invoice.advance,
                                          ignoreDecimal: false),
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold)),
                                ),
                              ]),
                          amountTable
                        ]),
                    pw.SizedBox(height: 10),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('GSTIN : 27ACGPY8550P1ZJ',
                              style: pw.TextStyle(
                                  color: PdfColors.red,
                                  letterSpacing: .45,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('FOR VISHAL ROADLINES',
                              style: pw.TextStyle(
                                  color: PdfColors.red,
                                  letterSpacing: .45,
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold)),
                        ]),
                    pw.SizedBox(height: 20),
                    pw.Container(
                      alignment: pw.Alignment.centerRight,
                      width: double.infinity,
                      child: pw.Text('Authorised Signatory',
                          style: pw.TextStyle(
                              fontSize: 8, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      width: double.infinity,
                      child: pw.Text('Bank Details',
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Divider(
                      height: 2
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('Account Name'),
                                pw.Text('Account Number'),
                                pw.Text('IFSC Code'),
                              ]),
                          pw.Column(children: [
                            pw.Text(' : '),
                            pw.Text(' : '),
                            pw.Text(' : '),
                          ]),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('VISHAL ROADLINES'),
                                pw.Text('629601010050010'),
                                pw.Text('UBIN0562963'),
                              ]),
                          pw.Row(children: [
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Bank Name'),
                                  pw.Text('Branch'),
                                ]),
                            pw.Column(children: [
                              pw.Text(' : '),
                              pw.Text(' : '),
                            ]),
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Union Bank Of India'),
                                  pw.Text('Louiswadi Thane (W)'),
                                ]),
                          ])
                        ]),
                        pw.Container(
                          width: double.infinity,
                          alignment: pw.Alignment.centerLeft,
                          child : 
                                  pw.Text('Note : As per provision of GST services is payable by Consignee/Consignor on RCM basis'),
                        )

                  ]),
            ),
            pw.Positioned(
                right: 0.0,
                child: pw.Container(
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                      pw.Text("Mob No. 9920833549"),
                      pw.Text("9987198275"),
                    ])))
          ])),
    ));

    // File IO for PDF
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/${widget.invoice.invoiceNo}.pdf');
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
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
                      (widget.invoice.getRideTotal() - widget.invoice.advance)
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
