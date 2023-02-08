import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/rideModule/provider/ride_provider.dart';

import '../../colors.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({super.key});

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    myInit();
  }

  myInit() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<RideProvider>(context, listen: false).fetchRides();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    final tS = MediaQuery.of(context).textScaleFactor;
    final rides = Provider.of<RideProvider>(context).rides;
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          backgroundColor: primaryColor,
          title: const Text("Rides"),
          elevation: 0,
        ),
        body: isLoading
            ? const SpinKitFadingCube(
                color: primaryColor,
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 0,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: dW * 0.025,
                ),
                itemBuilder: (BuildContext context, int index) => Material(
                  // elevation: 1.0,
                  // shadowColor: Colors.blueGrey,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rides[index].truckNumber,
                          style: TextStyle(
                              fontSize: tS * 15,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: dW * 0.01,
                        ),
                      ],
                    ),
                    trailing: Text(
                      "\u{20B9}${(rides[index].quantity * rides[index].rate) + rides[index].detention!}",
                      style: TextStyle(
                          fontSize: tS * 12,
                          letterSpacing: 0.68,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                itemCount: rides.length,
              ));
  }
}
