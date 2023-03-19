import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/colors.dart';
import 'package:transport_app/invoiceModule/models/invoice.dart';
import 'package:transport_app/invoiceModule/provider/invoice_provider.dart';
import 'package:transport_app/invoiceModule/widgets/invoice_card.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool isLoading = false;
  myInit() async {
    setState(() {
      isLoading = true;
    });
    Provider.of<InvoiceProvider>(context, listen: false).fetchInvoices();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    myInit();
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;

    final List<Invoice> invoices =
        Provider.of<InvoiceProvider>(context).invoices;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          backgroundColor: primaryColor,
          title: const Text("Invoices"),
          elevation: 0,
        ),
        endDrawer: Drawer(),
        body: isLoading
            ? const SpinKitFadingCube(
                color: primaryColor,
              )
            : SafeArea(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      vertical: dW * 0.05, horizontal: dW * 0.02),
                  itemBuilder: ((context, index) =>
                      InvoiceCard(invoice: invoices[index])),
                  itemCount: invoices.length,
                ),
              ));
  }
}
