import 'package:firebase_auth/firebase_auth.dart';
import 'package:users_app/models/user_model.dart';
//import 'package:kt_dart/kt.dart';
import '../models/direction_details_info.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId = "";
String cloudMessagingServerToken =
    "key=AAAAsgS0UA0:APA91bEPUBlEscxal4WL-ZyGJOWp_k58sqtM0vzIV34igjTcSaeXjaSVPj2K207ZoS8U6FxifDqmo2wu3z5zBL_WcAGSYg362N_1fpwtCPKJ6Q3TVeGx59mS9-QuguhTeBGKdqhedCN3";
String userPickAddress = "";
String driverCarDetails = "";
String driverName = "";
String driverPhone = "";
double countRatingStars = 0.0;
String titleStarsRating = "";
