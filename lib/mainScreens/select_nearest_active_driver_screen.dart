import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
//import 'package:users_app/assistants/assistant_methods.dart';

import 'package:users_app/global/global.dart';

class SelectNearestActiveDriversScreen extends StatefulWidget {
  DatabaseReference? referenceRideRequest;

  SelectNearestActiveDriversScreen({this.referenceRideRequest});

  @override
  _SelectNearestActiveDriversScreenState createState() =>
      _SelectNearestActiveDriversScreenState();
}

class _SelectNearestActiveDriversScreenState
    extends State<SelectNearestActiveDriversScreen> {
  String fareAmount = "";

  getFareAmountAccordingToVehicleType(int index) {
    if (dList[index]["Vehicle Details"]["vehicleModel"].toString() == "mazda") {
      fareAmount = 1500.toStringAsFixed(1);
    }
    if (dList[index]["Vehicle Details"]["vehicleModel"].toString() ==
        "tractor") {
      fareAmount = 1500.toStringAsFixed(1);
    }

    return fareAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text(
          "Nearest Online Bikes",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            //delete/remove the ride request from database
            widget.referenceRideRequest!.remove();
            Fluttertoast.showToast(msg: "you have cancelled the ride request.");
            SystemNavigator.pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: dList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                chosenDriverId = dList[index]["id"].toString();
              });
              Navigator.pop(context, "driverChosen");
            },
            // child: Card(
            //   color: Colors.grey,
            //   elevation: 3,
            //   shadowColor: Colors.green,
            //   margin: const EdgeInsets.all(8),
            //   child: ListTile(
            //     leading: Padding(
            //       padding: const EdgeInsets.only(top: 2.0),
            //       child: Text(
            //         dList[index]["Vehicle Details"]["vehicleModel"].toString() ,
            //
            //       ),
            //     ),
            //     title: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Text(
            //           dList[index]["name"],
            //           style: const TextStyle(
            //             fontSize: 14,
            //             color: Colors.black54,
            //           ),
            //         ),
            //         Text(
            //           dList[index]["Vehicle Details"]["vehicleModel"],
            //           style: const TextStyle(
            //             fontSize: 12,
            //             color: Colors.white54,
            //           ),
            //         ),
            //         SmoothStarRating(
            //           rating: dList[index]["ratings"] == null ? 0.0 : double.parse(dList[index]["ratings"]),
            //
            //           color: Colors.black,
            //           borderColor: Colors.black,
            //           allowHalfRating: true,
            //           starCount: 5,
            //           size: 15,
            //         ),
            //       ],
            //     ),
            //     trailing: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "RS " + getFareAmountAccordingToVehicleType(index),
            //           style: const TextStyle(
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         const SizedBox(height: 2,),
            //         Text(
            //           tripDirectionDetailsInfo != null ? tripDirectionDetailsInfo!.duration_text! : "",
            //           style: const TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black54,
            //               fontSize: 12
            //           ),
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),

            child: Column(
              children: dList.map((tx) {
                return Card(
                  margin: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  elevation: 20,
                  child: Container(
                    width: 400,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          width: 70,
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            "Rs" + tx.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                        Container(
                          height: 50,
                          margin: const EdgeInsetsDirectional.only(start: 40),
                          decoration: const BoxDecoration(),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx.title.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(
                                  height: 7,
                                ),
                                Text(tx.date!),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
