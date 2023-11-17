// ignore_for_file: non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/addVehicleScreen.dart';
import 'package:parkeasy/Screens/addVendorScreen.dart';
import 'package:parkeasy/Screens/allVendorScreen.dart';
import 'package:parkeasy/Screens/amountScreen.dart';
import 'package:parkeasy/Screens/phoneNoScreen.dart';
import 'package:parkeasy/Screens/priceScreen.dart';
import 'package:parkeasy/Screens/profileScreen.dart';
import 'package:parkeasy/Utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  String PhoneNo;

  HomeScreen({required this.PhoneNo, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  String userPhone = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    loadUserPhone();
  }

  Future<void> loadUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString('userPhone') ?? "";
    setState(() {
      userPhone = phone;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
          icon: Icon(
            MdiIcons.accountTieHat,
            size: 33,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color

          statusBarColor: primaryColor,
        ),
        backgroundColor: primaryColor,
        title: const Text(
          "ParkEasy",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 1),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext) {
                  return Dialog(
                      // backgroundColor: Colors.amber.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(50.0)), //this right here
                      child: SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Are you sure?",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor),
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Colors.black)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setBool('isLogged', false);
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen(),
                                          ));
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/hi.gif'),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.height * 0.3,
            ),
            // Text(widget.PhoneNo),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AmmountScreen(
                                phoneNo: widget.PhoneNo,
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(30),
                      color: primaryColor),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ListTile(
                    leading: Icon(
                      MdiIcons.car,
                      color: Colors.black,
                    ),
                    title: Text('Add Vehicle'),
                  ),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddVendorScreen(
                                phoneNO: widget.PhoneNo,
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(30),
                      color: primaryColor),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ListTile(
                    leading: Icon(
                      MdiIcons.account,
                      color: Colors.black,
                    ),
                    title: const Text('Add Vendors'),
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final User? user = _auth.currentUser;
                        if (user != null) {
                          final uid = user.uid;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PriceScreen(widget.PhoneNo),
                            ),
                          );
                        } else {
                          print('User is not logged in.');
                        }
                      },
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: primaryColor,
                          child: Center(
                              child: Icon(
                            MdiIcons.currencyRupee,
                            color: Colors.black,
                            size: 40,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.009,
                    ),
                    const AutoSizeText(
                      'Vehicle Pricing',
                      style: TextStyle(fontSize: 17),
                      maxLines: 1,
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final User? user = _auth.currentUser;
                        if (user != null) {
                          final uid = user.uid;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VendorScreen(uid),
                            ),
                          );
                        } else {
                          print('User is not logged in.');
                        }
                      },
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: primaryColor,
                          child: Center(
                              child: Icon(
                            MdiIcons.account,
                            color: Colors.black,
                            size: 40,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.009,
                    ),
                    const AutoSizeText(
                      'Vendors',
                      style: TextStyle(fontSize: 17),
                      maxLines: 1,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
