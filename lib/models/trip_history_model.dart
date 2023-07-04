import 'package:firebase_database/firebase_database.dart';

class TripsHistoryModel {
  String? time;
  String? originAddress;
  String? destinationAddress;
  String? status;
  String? fareAmount;
  String? vehicleDetails;
  String? driverName;

  TripsHistoryModel({
    this.time,
    this.originAddress,
    this.destinationAddress,
    this.status,
    this.vehicleDetails,
    this.driverName,
  });

  TripsHistoryModel.fromSnapshot(DataSnapshot dataSnapshot) {
    time = (dataSnapshot.value as dynamic)["time"];
    originAddress = (dataSnapshot.value as dynamic)["originAddress"];
    destinationAddress = (dataSnapshot.value as dynamic)["destinationAddress"];
    status = (dataSnapshot.value as dynamic)["status"];
    fareAmount = (dataSnapshot.value as dynamic)["fareAmount"];
    vehicleDetails = (dataSnapshot.value as dynamic)["Vehicle Details"];
    driverName = (dataSnapshot.value as dynamic)["driverName"];
  }
}
