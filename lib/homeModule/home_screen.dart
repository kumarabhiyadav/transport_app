import 'package:flutter/material.dart';
import 'package:transport_app/colors.dart';
import 'package:transport_app/homeModule/new_invoice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Invoices',
          style: TextStyle(letterSpacing: .88),
        ),
        backgroundColor: primaryColor,
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewInvoiceScreen()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                'New Invoice',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
