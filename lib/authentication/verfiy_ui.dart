import 'package:flutter/material.dart';

class FingerPrintVerify extends StatefulWidget {
  const FingerPrintVerify({Key? key}) : super(key: key);

  @override
  _FingerPrintVerifyState createState() => _FingerPrintVerifyState();
}

class _FingerPrintVerifyState extends State<FingerPrintVerify> {
  @override
  @override
  Widget build(BuildContext context) {
    Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.25),
      child: const Icon(
        Icons.fingerprint,
        size: 48,
        color: Colors.black,
      ),
    );
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.fingerprint,
            size: 48,
            color: Colors.black,
          ),
          SizedBox(height: 18),
          Text(
            "Verify Successfully",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
