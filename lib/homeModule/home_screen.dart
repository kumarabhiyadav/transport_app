import 'package:flutter/material.dart';

import 'package:transport_app/colors.dart';
import 'package:transport_app/customerModule/screens/customer_screen.dart';
import 'package:transport_app/invoiceModule/screens/invoice_screen.dart';
import 'package:transport_app/rideModule/screens/rides_screen.dart';

import '../invoiceModule/screens/create_new_invoice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final dH = MediaQuery.of(context).size.height;
    final tS = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Home"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_active))
        ],
      ),
      drawer: const Drawer(),
      body: Column(children: [
        Container(
          height: dH * 0.3,
          width: dW,
          color: primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: dW * 0.11,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: greyColor,
                  size: dW * 0.1,
                ),
              ),
              SizedBox(
                height: dH * 0.025,
              ),
              Text(
                "Welcome, Abhinav Yadav",
                style: TextStyle(
                    fontSize: tS * 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .48,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        Container(
          color: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: dW * 0.05),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: dH * 0.02,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.library_add_check_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: dH * 0.01,
                    ),
                    Text(
                      'QUICK CREATE',
                      style: TextStyle(
                          fontSize: tS * 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeOptions(
                    function: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateNewInvoice())),
                    icon: Icons.receipt_long,
                    title: 'Create Invoice',
                  ),
                  HomeOptions(
                    function: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InvoiceScreen())),
                    icon: Icons.receipt,
                    title: 'Invoices',
                  ),
                ],
              ),
              SizedBox(
                height: dH * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeOptions(
                    title: 'Rides',
                    function: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RideScreen())),
                    icon: Icons.airport_shuttle_outlined,
                  ),
                  HomeOptions(
                    function: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CustomerScreen())),
                    icon: Icons.person_outline,
                    title: 'Add Customer',
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class HomeOptions extends StatelessWidget {
  const HomeOptions(
      {super.key,
      required this.title,
      required this.function,
      required this.icon});
  final String title;
  final IconData icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: greyColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.01),
              spreadRadius: 0.4,
              blurRadius: .07,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        height: dW * 0.42,
        width: dW * 0.42,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.black45,
            ),
            // Icon(
            //   Icons.person_outline,
            //   color: Colors.grey,
            //   size: 50,
            // ),
            SizedBox(
              height: dW * 0.04,
            ),
            Text(
              title,
              style: TextStyle(fontSize: tS * 15),
            )
          ],
        ),
      ),
    );
  }
}
