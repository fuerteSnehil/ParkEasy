import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  String? phoneNo; // Store the phone number in a variable

  @override
  void initState() {
    super.initState();
    loadPhoneFromSharedPreferences(); // Load the phone number from SharedPreferences
  }

  Future<void> loadPhoneFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNo = prefs.getString('phone');
    });
  }

  Future<void> fetchUserData() async {
    if (phoneNo != null) {
      final firestore = FirebaseFirestore.instance;
      final userDoc = await firestore.collection('AllUsers').doc(phoneNo).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final name = userData['name'];
        final phoneNumber = userData['phone'];
        // Set the retrieved user data here if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<LoginProvider>(context, listen: false);

    if (phoneNo != null) {
      fetchUserData(); // Fetch user data if phone number is available
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          PhoneNo: '',
                        )));
          },
        ),
        title: const Text(
          'Your profile',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 1),
        ),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.amber,
                backgroundColor: Colors.black,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/details.gif',
                    scale: 1,
                  ),
                  const SizedBox(height: 10),
                  if (phoneNo != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        'Phone No:$phoneNo',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ),
                  const SizedBox(height: 10),
                ],
              ),
      ),
    );
  }
}
