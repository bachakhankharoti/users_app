import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                  // width: MediaQuery.of(context).size.width - 50,
                  // height: 250,
                ),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
           const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                style:
                ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 8, 12, 231),
                  minimumSize: const Size(200, 50),
                );
                try {
                  await _auth.sendPasswordResetEmail(
                      email: _emailController.text.trim());
                  _showToast(
                      'Password reset email sent. Please check your inbox.');
                } on FirebaseAuthException catch (e) {
                  _showToast(e.message ??
                      'An error occurred while resetting the password.');
                }
              },
              child:  Text(
                'Reset Password',
                style:  TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
