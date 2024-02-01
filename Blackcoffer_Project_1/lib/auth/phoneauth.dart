import 'package:blackcoffer/auth/otpscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
   PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title:  const Text("OTP Authentication"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  suffixIcon:  const Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
          ),
           const SizedBox(height: 35),
          ElevatedButton(
              onPressed: () async {
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
              child:  const Text("Verify Phone number"))
        ],
      ),
    );
  }
}
