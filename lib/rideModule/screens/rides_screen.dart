// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/rideModule/model/ride_model.dart';
import 'package:transport_app/rideModule/provider/ride_provider.dart';
import 'package:transport_app/rideModule/screens/add_new_ride_screen.dart';

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

  showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  deleteRideDialog(String rideId, String truckNumber, double ts) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(
            'Do you want to delete this ride',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: ts * 15),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                setState(() {
                  isLoading = true;
                });
                final result =
                    await Provider.of<RideProvider>(context, listen: false)
                        .deleteRide(rideId);

                if (result) {
                  showMessage('Ride has been deleted successfull');
                } else {
                  showMessage('Failed to delte ride');
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
              ),
            ),
          ],
          content: Text(
            'Ride of $truckNumber will be lost forever',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: ts * 14),
          ),
        ),
      );

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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewRideScreen(
                        from: 'ridesScreen',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: isLoading
            ? const SpinKitFadingCube(
                color: primaryColor,
              )
            : rides.isEmpty
                ? SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.airport_shuttle_outlined),
                        Text("We don't have any ride")
                      ],
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      height: dW * 0.055,
                      color: Colors.transparent,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: dW * 0.025,
                    ),
                    itemBuilder: (BuildContext context, int index) => Material(
                        // elevation: 1.0,
                        // shadowColor: Colors.blueGrey,
                        child: GestureDetector(
                      onLongPress: () => deleteRideDialog(
                          rides[index].id, rides[index].truckNumber, tS),
                      child: RideCard(dW: dW, ride: rides[index], tS: tS),
                    )),
                    itemCount: rides.length,
                  ));
  }
}

class RideCard extends StatelessWidget {
  const RideCard({
    Key? key,
    required this.dW,
    required this.ride,
    required this.tS,
  }) : super(key: key);

  final double dW;
  final Ride ride;
  final double tS;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(dW * 0.04),
      margin: EdgeInsets.symmetric(horizontal: dW * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ride.customer,
                style: TextStyle(
                    fontSize: tS * 12,
                    letterSpacing: .80,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                DateFormat('dd MMM yyyy').format(ride.date),
                style:
                    TextStyle(fontWeight: FontWeight.w300, fontSize: tS * 15),
              )
            ],
          ),
          SizedBox(
            height: dW * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ride.truckNumber,
                style: TextStyle(fontSize: tS * 18, letterSpacing: .90),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.purple,
                ),
                child: Text(
                  ride.particular,
                  style: TextStyle(
                      fontSize: tS * 12,
                      letterSpacing: .90,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Icon(Icons.location),

              Text(
                'From',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .80,
                    fontSize: tS * 12),
              ),

              const Icon(Icons.arrow_forward),

              Text(
                'To',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .80,
                    fontSize: tS * 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ride.source!,
                style: TextStyle(fontSize: tS * 18, letterSpacing: .90),
              ),
              Text(
                ride.destination!,
                style: TextStyle(fontSize: tS * 18, letterSpacing: .90),
              )
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .80,
                    fontSize: tS * 12),
              ),
              Text(
                'Rate',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .80,
                    fontSize: tS * 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: dW * 0.25,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    ride.quantity.toStringAsFixed(2),
                    style: TextStyle(fontSize: tS * 18, letterSpacing: .90),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: dW * 0.25,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "\u{20B9}${ride.rate.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: tS * 18, letterSpacing: .90),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Detention',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .80,
                    fontSize: tS * 12),
              ),
              Text(
                'Total Amount',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .80,
                    fontSize: tS * 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: dW * 0.25,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    ride.detention!.toStringAsFixed(2),
                    style: TextStyle(fontSize: tS * 18, letterSpacing: .90),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: dW * 0.3,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "\u{20B9}${((ride.quantity * ride.rate) + ride.detention!).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: tS * 18, letterSpacing: .90),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
