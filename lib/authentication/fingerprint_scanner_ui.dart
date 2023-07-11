import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:local_auth/local_auth.dart';

import 'verfiy_ui.dart';

class FingerprintPage extends StatefulWidget {
  const FingerprintPage({Key? key}) : super(key: key);

  @override
  State<FingerprintPage> createState() => _FingerprintPageState();
}

class _FingerprintPageState extends State<FingerprintPage> {
  late bool isAvailable;
  late bool hasFingerprint;
  checkAvablity() async {
    isAvailable = await LocalAuthApi.hasBiometrics();
    final biometrics = await LocalAuthApi.getBiometrics();

    hasFingerprint = biometrics.contains(BiometricType.fingerprint);

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildText('Biometrics', isAvailable),
        buildText('Fingerprint', hasFingerprint),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: const Text(""),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.only(
            top: 33,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 8,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(35), topLeft: Radius.circular(35)),
              border: Border.all(color: Colors.transparent)),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "use Fingerprint to Open",
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.8)),
                ),
                Text(
                  "Bike Sharing System App",
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.8)),
                ),
                const SizedBox(height: 130),
                /*
                Text(
                  "fingerprint",
                  style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.8)),
                ),*/
                const SizedBox(height: 30),
                /*   Text(
                  "let us know it's you by one click authentication",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.withOpacity(0.8)),
                ),*/
                /*
                LottieBuilder.asset(
                  "assets/fin.json",
                  repeat: true,
                ),*/
                FutureBuilder(
                    future: checkAvablity(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Colors.green,
                          strokeWidth: 2,
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // buildText('Biometrics Hardware  ', isAvailable),
                            buildText(
                                'Fingerprint Availability ', hasFingerprint),
                            const SizedBox(height: 180),
                            authenticateButton(context)
                          ],
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      );
}

//
class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      // checking if the user has biometric hardware
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
          localizedReason: 'Scan Fingerprint to Authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
    } on PlatformException catch (e) {
      return false;
    }
  }
}

Widget buildText(String text, bool checked) => Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          checked
              ? const Icon(Icons.check, color: Colors.green, size: 24)
              : const Icon(Icons.close, color: Colors.red, size: 24),
          const SizedBox(width: 3),
          Text(text,
              style: TextStyle(
                  fontSize: 15, color: Colors.black.withOpacity(0.6))),
        ],
      ),
    );
Widget authenticateButton(context) {
  return Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
    width: MediaQuery.of(context).size.width * 0.4,
    child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.white,
          minimumSize: const Size.fromHeight(40),
        ),
        icon: const Icon(
          Icons.fingerprint,
          size: 33,
          color: Colors.green,
        ),
        label: const Text(
          "sign in",
          style: TextStyle(
            fontSize: 10,
            color: Colors.green,
          ),
        ),
        onPressed: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            Get.offAll(() => const FingerPrintVerify());
          }
        }),
  );
}
