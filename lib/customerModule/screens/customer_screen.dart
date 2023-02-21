import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/customerModule/model/customer.dart';
import 'package:transport_app/customerModule/provider/customer_provider.dart';

import 'package:transport_app/customerModule/screens/add_customer_screen.dart';

import '../../colors.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  bool isLoading = false;

  myInit() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<CustomerProvider>(context, listen: false)
        .fetchCustomers();
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
    final tS = MediaQuery.of(context).textScaleFactor;
    final List<Customer> customers =
        Provider.of<CustomerProvider>(context).customers;
    return Scaffold(
      body: isLoading
          ? const SpinKitFadingCube(
              color: primaryColor,
            )
          : customers.isEmpty
              ? const Center(
                  child: Text("No Customer Avalible"),
                )
              : ListView.separated(
                  separatorBuilder: ((context, index) => const Divider()),
                  itemBuilder: ((context, index) => ListTile(
                        leading: CircleAvatar(child: Icon(Icons.person)),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customers[index].companyName,
                              style: TextStyle(
                                  fontSize: tS * 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: .56),
                            ),
                            Text(
                              customers[index].customerName,
                              style: TextStyle(
                                  fontSize: tS * 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .56),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.phone)),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete_forever))
                          ],
                        ),
                      )),
                  itemCount: customers.length,
                ),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        backgroundColor: primaryColor,
        title: const Text("Customers"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCustomerScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
