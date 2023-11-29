import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indian_currency_to_word/indian_currency_to_word.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:transport_app/invoiceModule/models/invoice.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';

loadLogo() async {
  final ByteData bytes =
      await rootBundle.load('assets/images/vishalroadlinelogo.jpeg');
  final Uint8List byteList = bytes.buffer.asUint8List();
  return byteList;
}

newPdf({required Invoice invoice}) async {
  final logo = await loadLogo();
  final converter = AmountToWords();

  final headers = [
    'Tanker No.',
    'L.R.No.',
    'Date',
    'Rate(Rs.)',
    'Quantity(Kg.)',
    'Detention',
    'PARTICULARS',
    'Amount(Rs.)'
  ];
  List<List<String>> data = [];

  for (int i = 0; i <= 15; i++) {
    if (i < invoice.rides.length) {
      Ride ride = invoice.rides[i];
      List<String> temp = [];
      temp.add(ride.truckNumber);
      temp.add(ride.lrNo);
      temp.add(DateFormat('dd-MM-yy').format(ride.date));
      temp.add(ride.rate.toStringAsFixed(2));
      temp.add(ride.quantity.toStringAsFixed(2));
      temp.add(
          ride.detention! < 1.00 ? '' : ride.detention!.toStringAsFixed(2));
      temp.add(ride.particular.toUpperCase());
      temp.add(((ride.quantity * ride.rate) + (ride.detention! > 0.00
              ? ride.detention!
              : 0.00))
          .toStringAsFixed(2));
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
      temp.add("");
      data.add(temp);
    }
  }

  final tableHeaders = headers.map((header) {
    return pw.Container(
      height: 20,
      width: getWidthForColumn(header),
      padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      alignment: pw.Alignment.center,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
      ),
      child: pw.FittedBox(
          child: pw.ConstrainedBox(
              constraints: const pw.BoxConstraints(minHeight: 1, minWidth: 1),
              child: pw.Text(header,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))),
    );
  }).toList();

  final tableRows = data.map((row) {
    return row.asMap().entries.map((cell) {
      return pw.Container(
        height: 18,
        width: getWidthForColumnContent(cell.key),
        padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        alignment: pw.Alignment.center,
        decoration: const pw.BoxDecoration(
          border: pw.Border.symmetric(
              vertical: pw.BorderSide(color: PdfColors.black)),
        ),
        child: pw.Container(
          child: pw.FittedBox(
            fit: pw.BoxFit.scaleDown,
            child: pw.ConstrainedBox(
              constraints: const pw.BoxConstraints(minWidth: 1, minHeight: 1),
              child: pw.Text(cell.value,
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(fontSize: 10.00)),
            ),
          ),
        ),
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
  amountTableRow
      .add(['Amount', "${invoice.getRideTotal().toStringAsFixed(2)} Rs."]);
  amountTableRow.add(['Advance', "${invoice.advance.toStringAsFixed(2)} Rs."]);
  amountTableRow.add([
    'Balance',
    "${(invoice.getRideTotal() - invoice.advance).toStringAsFixed(2)} Rs."
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
                      style: pw.TextStyle(color: PdfColor.fromHex('#FF0000'))),
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
                        pw.Text('No. ${invoice.invoiceNo}',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Row(children: [
                          pw.Text('Date : '),
                          pw.Text(DateFormat('dd-MM-yyyy').format(invoice.date))
                        ]),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                              pw.Text('M/s'),
                              pw.Container(
                                  width: 280,
                                  padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 4),
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      children: [
                                        pw.Text(invoice.customer.companyName,
                                            style: pw.TextStyle(
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.Container(
                                          height: 12,
                                          // child: pw.FittedBox(
                                          // fit: pw.BoxFit.scaleDown,
                                          child: pw.Text(
                                            invoice.customer.address,
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                fontWeight: pw.FontWeight.bold),
                                          ),
                                        ),
                                      ]))
                            ])),
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
                        pw.Text(" ${invoice.source.toUpperCase()} ",
                            style: pw.TextStyle(
                                decoration: pw.TextDecoration.underline,
                                fontWeight: pw.FontWeight.bold,
                                letterSpacing: 0.56)),
                        pw.SizedBox(width: 50),
                        pw.Text("To : "),
                        pw.Text(" ${invoice.destination.toUpperCase()} ",
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
                                        invoice.getRideTotal() -
                                            invoice.advance,
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
                  pw.Divider(height: 2),
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
                    child: pw.Text(
                        'Note : As per provision of GST services is payable by Consignee/Consignor on RCM basis'),
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
                  ]),
            ),
          ),
          pw.Positioned(
            left: 0.0,
            child: pw.Container(
                child: pw.Image(
                    pw.MemoryImage(
                      logo,
                    ),
                    fit: pw.BoxFit.contain,
                    height: 120,
                    width: 120)),
          )
        ])),
  ));

  // File IO for PDF
  final appDocDir = await getApplicationDocumentsDirectory();
  final appDocPath = appDocDir.path;
  final file = File('$appDocPath/${invoice.invoiceNo}.pdf');
  debugPrint('Save as file ${file.path} ...');
  await file.writeAsBytes(await pdf.save());
  await OpenFile.open(file.path);
}

getWidthForColumn(header) {
  switch (header) {
    case 'Tanker No.':
      return 30.00;
    case 'L.R.No.':
      return 20.00;
    case 'Date':
      return 20.00;
    case 'Rate':
      return 20.00;
    case 'Quantity':
      return 30.00;
    case 'Detention':
      return 25.00;
    case 'PARTICULARS':
      return 40.00;
    case 'Amount(Rs.)':
      return 30.00;
    default:
      return 0.00;
  }
}

getWidthForColumnContent(index) {
  switch (index) {
    case 0:
      return 30.00;
    case 1:
      return 20.00;
    case 2:
      return 20.00;
    case 3:
      return 20.00;
    case 4:
      return 30.00;
    case 5:
      return 25.00;
    case 6:
      return 40.00;
    case 7:
      return 30.00;
    default:
      return 0.00;
  }
}
