import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Screens/registerScreen.dart';
import 'package:parkeasy/Utils/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PhoneAuthentication {
  final BuildContext context;
  final bool mounted;
  LoginProvider lp;
  PhoneAuthentication({
    required this.context,
    required this.mounted,
    required this.lp,
  });

  final FirebaseAuth _fa = FirebaseAuth.instance;
  // final Backend _backend = Backend();
  bool _isLoading = false;
  Future<String> sendPhoneOtp() async {
    String result = "";
    lp.startProcessing();
    await _fa.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: lp.phone,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        lp.startProcessing();
        lp.setSmsCode = phoneAuthCredential.smsCode!;
        Future.delayed(
          const Duration(milliseconds: 250),
          () async => result = await _afterSendingOtp(phoneAuthCredential),
        );
        lp.endProcessing();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.message!.contains("Network")) {
          result = "Please check your internet connection.";
        } else if (e.code.contains("too-many-requests")) {
          result =
              "You've made too many requests, please try again after some time.";
        } else if (e.code.contains("invalid-phone-number")) {
          result = "Invalid phone number.";
        } else {
          result = "Something went wrong, please try later.";
        }
      },
      codeSent: (verificationID, [int? forceResendingToken]) {
        lp.setVerificationID = verificationID;
        if (mounted) {
          showSnackBar(context, "OTP sent successfully.");
        }
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
    lp.endProcessing();
    return result;
  }

  Future<String> verifyPhoneOTP() async {
    String code = "";
    for (TextEditingController controller in lp.controllers) {
      code += controller.text;
    }
    lp.setSmsCodeManually = code;
    if (lp.smsCode.length == 6) {
      String result = await _afterSendingOtp(PhoneAuthProvider.credential(
        verificationId: lp.verificationID,
        smsCode: lp.smsCode,
      ));

      if (result == "Login successful.") {
        // User successfully logged in, set the bool value to true
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogged', true);
        await _setUserLoggedIn(lp.phone);
      }

      return result;
    } else {
      return "Incorrect OTP entered.";
    }
  }

  Future<String> _afterSendingOtp(
      PhoneAuthCredential phoneAuthCredential) async {
    lp.startProcessing();
    String result = "Login successful.";

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        try {
          if (userCredential.additionalUserInfo!.isNewUser) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => UserInformationScreen(
                  phoneNumber: lp.phone,
                  verificationID: lp.verificationID,
                ),
              ),
              (route) => false,
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  PhoneNo: lp.phone,
                ),
              ),
              (route) => false,
            );
          }
        } catch (e) {
          result = "Something went wrong!";
          debugPrint(e.toString());
        }
      }
    } catch (e) {
//this account is invalid
      if (e.hashCode == 130296352) {
        result = "Account already exists.";
      } else {
        result = "Something went wrong.";
      }
    }

    lp.endProcessing();
    return result;
  }

  Future<void> _setUserLoggedIn(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userPhone', phone);
  }

  Future<bool> checkIfUserExists(String phoneNumber) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    final DocumentSnapshot userDocument =
        await usersCollection.doc(phoneNumber).get();

    return userDocument.exists;
  }
}
