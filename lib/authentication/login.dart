//import 'package:bike_sharing_system/splashscreen/splash_screen.dart';
//import 'package:bike_sharing_system/weights/progress_dialog.dart';
//import 'package:bike_sharing_system/authentication/signup_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/forgot_password.dart';
import 'package:users_app/authentication/signup.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
//import '../global/global.dart';

import '../global/global.dart';
import '../mainScreens/main_screen.dart';
import '../widgets/progress_dialog.dart';
import 'fingerprint_scanner_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isPasswordVisible = false;

  get phoneNumber => null;

  validateForm() {
    if (!_email.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email Address is not valid.");
    } else if (_password.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password must be required.");
    } else if (_password.text != "correct_password") {
      // Replace "correct_password" with the actual correct password
      Fluttertoast.showToast(msg: "Wrong password entered.");
    } else {
      loginUserNow();
    }
  }

  //without wrong pass msg is show
/*
  validateForm() {
    if (!_email.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email Address is not valid.");
    } else if (_password.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password must be required.");
    } else if (_password.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password must be required.");
    } 
    else {
      loginUserNow();
    }
  }
*/
  loginUserNow() async {
    /*  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(message: "Processing, Please wait...");
      },
    );
*/
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: _email.text.trim(),
      password: _password.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;
    if (firebaseUser != null) {
      DatabaseReference driversRef = FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(firebaseUser.uid);
      driversRef.child(firebaseUser.uid).once().then((driverkey) {
        final snap = driverkey.snapshot;
        if (snap.value != null) {
          var currentfirebaseuser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => MainScreen()));
        }
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred During Sign In.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "images/2.png",
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Login as a User",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Color.fromARGB(255, 8, 3, 3)),
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  hintText: "Email Address",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              TextField(
                controller: _password,
                keyboardType: TextInputType.text,
                obscureText: !_isPasswordVisible,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const FingerprintPage()),
                    );
                  },
                  child: const Text(
                    "login with fingerprint",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const ForgotPasswordScreen()),
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 30, 8, 231),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                child: const Text(
                  "Already have an Account? Signup Here",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
