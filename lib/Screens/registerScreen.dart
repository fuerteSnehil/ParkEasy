import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkeasy/Models/usermodel.dart';
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Utils/colors.dart';
import 'package:parkeasy/Utils/constants.dart';
import 'package:parkeasy/Utils/utils.dart';
import 'package:parkeasy/widgets/custombtn.dart';
import 'package:provider/provider.dart';

class UserInformationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationID;
  const UserInformationScreen(
      {required this.phoneNumber, required this.verificationID, super.key});

  @override
  State<UserInformationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInformationScreen> {
  // File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }

  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<LoginProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: amber,
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/user.gif'),
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.height * 0.3,
                            ),
                            // name field
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                controller: nameController,
                                onTap: () => _requestFocus(nameFocusNode),
                                focusNode: nameFocusNode,
                                cursorColor: black,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: "Full Name",
                                  labelStyle: TextStyle(
                                      color: nameFocusNode.hasFocus
                                          ? black
                                          : Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: nameFocusNode.hasFocus
                                            ? black
                                            : Colors.black54),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: black),
                                  ),
                                ),
                                onChanged: (value) {
                                  checkTextFieldLength(value);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                controller: emailController,
                                onTap: () => _requestFocus(emailFocusNode),
                                focusNode: emailFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                cursorColor: black,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: emailFocusNode.hasFocus
                                          ? black
                                          : Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: emailFocusNode.hasFocus
                                            ? black
                                            : Colors.black54),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: black),
                                  ),
                                ),
                                onChanged: (value) =>
                                    checkTextFieldLength(emailController.text),
                              ),
                            ),

                            // dob
                            // Container(
                            //   height: 55,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     color: Colors.amber.shade50,
                            //   ),
                            //   child: TextField(
                            //     controller: bioController,
                            //     //editing controller of this TextField
                            //     decoration: InputDecoration(
                            //       contentPadding: EdgeInsets.all(20),
                            //       icon: Container(
                            //         height: 33,
                            //         width: 33,
                            //         margin: const EdgeInsets.all(8.0),
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(8),
                            //           color: amber,
                            //         ),
                            //         child: Icon(
                            //           Icons.calendar_today,
                            //           size: 20,
                            //           color: Colors.black,
                            //         ),
                            //       ), //icon of text field
                            //       border: InputBorder.none,
                            //       hintText: "Date of birth",
                            //       alignLabelWithHint: true,
                            //       //label text of field
                            //     ),
                            //     readOnly: true,
                            //     //set it true, so that user will not able to edit text
                            //     onTap: () async {
                            //       DateTime? pickedDate = await showDatePicker(
                            //           context: context,
                            //           initialDate: DateTime.now(),
                            //           firstDate: DateTime(1950),
                            //           //DateTime.now() - not to allow to choose before today.
                            //           lastDate: DateTime.now());

                            //       if (pickedDate != null) {
                            //         print(
                            //             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            //         String formattedDate =
                            //             DateFormat('yMd').format(pickedDate);
                            //         print(
                            //             formattedDate); //formatted date output using intl package =>  2021-03-16
                            //         setState(() {
                            //           bioController.text =
                            //               formattedDate; //set output date to TextField value.
                            //         });
                            //       } else {}
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: GestureDetector(
                          onTap: () =>
                              isButtonEnabled ? UploadeUserdata() : null,
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: isButtonEnabled
                                    ? amber
                                    : Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                                child: Text(
                              "CONTINUE",
                              style: TextStyle(
                                  letterSpacing: 2,
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    required keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        cursorColor: Colors.amber,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: amber,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.amber.shade50,
          filled: true,
        ),
      ),
    );
  }

  void checkTextFieldLength(String value) {
    setState(() {
      isButtonEnabled =
          nameController.text.length > 2 && validateEmail(emailController.text);
      isButtonEnabled = true;
    });
  }

  void _requestFocus(FocusNode myFocus) {
    setState(() {
      FocusScope.of(context).requestFocus(myFocus);
    });
  }

  bool validateEmail(String email) {
    isButtonEnabled = true;
    // Regular expression pattern for a simple email validation
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void UploadeUserdata() async {
    try {
      final phoneNumber = widget.phoneNumber;
      final userName = nameController.text;
      final uId = widget.phoneNumber;
      final String email = emailController.text;

      final userProfileCollection =
          FirebaseFirestore.instance.collection("AllUsers");

      final userData = <String, dynamic>{
        'phone': phoneNumber,
        'name': userName,
        'uID': uId,
        'email': email,
        'createdAt': DateTime.now().toString(),
      };

      await userProfileCollection.doc(uId).set(userData).then((_) {
        log("Data Uploaded successfull!");
      }).catchError((error) {
        log('Error uploading data: $error');
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              PhoneNo: uId,
            ),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      print(e);
    }
  }
}
