import 'dart:developer' show log;

import 'package:blackcoffer/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  String verificationid;
  OTPScreen({super.key, required this.verificationid});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("OTP SCREEN"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: otpcontroller,
              decoration: InputDecoration(
                  hintText: "Enter the OTP",
                  suffixIcon:  const Icon(Icons.phone_android),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35))),
            ),
          ),
           const SizedBox(height: 35),
          ElevatedButton(
              onPressed: () async {
                var phoneController;
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verificationid, int? resendtoken) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPScreen(
                                    verificationid: verificationid,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                    phoneNumber: phoneController.text.toString());
              },
              child: const Text("Did not get OTP, Resend?")),
           const SizedBox(height: 35),
          ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationid,
                      smsCode: otpcontroller.text.toString());
                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                 const MyHomePage(title: "MY app")));
                  });
                } catch (ex) {
                  log(ex.toString());
                }
              },
              child:  const Text("Get Started")),
        ],
      ),
    );
  }
}
