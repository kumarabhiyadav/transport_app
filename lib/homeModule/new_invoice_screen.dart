import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transport_app/colors.dart';
import 'package:transport_app/commonWidgets.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: dW * 0.05,
        title: const Text(
          'New Invoice',
          style: TextStyle(letterSpacing: .88),
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: dW * 0.02, vertical: dW * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Company Name',
                  style: titleTextStyle(),
                ),
                SizedBox(
                  height: dW * 0.03,
                ),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: textformFeildDecoration('Company Name')),
                SizedBox(
                  height: dW * 0.05,
                ),
                Text(
                  'Date',
                  style: titleTextStyle(),
                ),
                SizedBox(
                  height: dW * 0.03,
                ),
                InkWell(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(DateTime.now().year + 2))
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          dateController.text =
                              DateFormat("dd MMM yyyy").format(value);
                        });
                      }
                    });
                  },
                  child: TextFormField(
                      controller: dateController,
                      textInputAction: TextInputAction.next,
                      enabled: false,
                      decoration: textformFeildDecoration('Date')),
                ),
                SizedBox(
                  height: dW * 0.05,
                ),
                Text(
                  'Source',
                  style: titleTextStyle(),
                ),
                SizedBox(
                  height: dW * 0.03,
                ),
                TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: textformFeildDecoration('From')),
                SizedBox(
                  height: dW * 0.05,
                ),
                Text(
                  'Destination',
                  style: titleTextStyle(),
                ),
                SizedBox(
                  height: dW * 0.03,
                ),
                TextFormField(
                    textInputAction: TextInputAction.done,
                    decoration: textformFeildDecoration('To..'))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: dW * 0.15,
          color: primaryColor,
          alignment: Alignment.center,
          child: const Text(
            'Next',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                letterSpacing: .56),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
