import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/customerModule/provider/customer_provider.dart';
import 'package:transport_app/homeModule/home_screen.dart';
import 'package:transport_app/invoiceModule/provider/invoice_provider.dart';
import 'package:transport_app/rideModule/provider/ride_provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RideProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => InvoiceProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'transport',
        home: HomeScreen(),
      ),
    );
  }
}
