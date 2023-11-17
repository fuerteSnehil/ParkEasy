import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/addVehicleScreen.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Screens/priceScreen.dart';
import 'package:parkeasy/Utils/utils.dart';
import 'package:provider/provider.dart';

class AmmountScreen extends StatefulWidget {
  final String phoneNo;

  const AmmountScreen({super.key, required this.phoneNo});
  @override
  State<AmmountScreen> createState() => _AmmountScreenState();
}

class _AmmountScreenState extends State<AmmountScreen> {
  // final String tappedValue;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final vehicleController = TextEditingController();

  final ammountController = TextEditingController();

  final ammountController30Min = TextEditingController();

  final ammountController120Min = TextEditingController();

  final ammountControllerMoreThen120Min = TextEditingController();

  void dispose() {
    ammountController.dispose();
    vehicleController.dispose();
  }

  void setamount(String uid, String vehicle, String amount) async {}

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          PhoneNo: widget.phoneNo,
                        )));
          },
        ),
        title: const Text(
          'Set Amount',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              letterSpacing: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/doller.gif'),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
              ),
              // Image.asset(
              //   tappedImage,
              //   height: MediaQuery.of(context).size.height * 0.1,
              //   width: MediaQuery.of(context).size.width * 0.3,
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.04,
              // ),
              // Image.asset(),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: vehicleController,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    hintText: 'Vehicle name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 224, 169, 4)),
                    ),
                  ),
                  // controller: vehicleController,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: ammountController30Min,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      MdiIcons.currencyRupee,
                      color: Colors.black,
                    ),
                    hintText: 'Enter an amount for 30 min',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 224, 169, 4)),
                    ),
                  ),
                  // controller: vehicleController,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: ammountController120Min,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      MdiIcons.currencyRupee,
                      color: Colors.black,
                    ),
                    hintText: 'Enter amount for 120 min',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 224, 169, 4)),
                    ),
                  ),
                  // controller: vehicleController,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: ammountControllerMoreThen120Min,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.amber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      MdiIcons.currencyRupee,
                      color: Colors.black,
                    ),
                    hintText: 'Enter amount for more then 120 min',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black38),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 224, 169, 4)),
                    ),
                  ),
                  // controller: vehicleController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: TextButton(
                      onPressed: () {
                        final String vehicleName = vehicleController.text;
                        final String amount30Min = ammountController30Min.text;
                        final String amount120Min =
                            ammountController120Min.text;
                        final String amountMoreThan120Min =
                            ammountControllerMoreThen120Min.text;

                        createSubcollection(context, vehicleName, amount30Min,
                            amount120Min, amountMoreThan120Min, widget.phoneNo);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.amber),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ListTile(
                          leading: Icon(
                            MdiIcons.check,
                            color: Colors.black,
                          ),
                          title: const Text('Set Amount'),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createSubcollection(
    BuildContext context,
    String vehicleName,
    String amount30,
    String amount120,
    String amountMoreThan120,
    String phoneNo,
  ) async {
    if (vehicleName.isEmpty) {
      showSnackBar(context, "Please Enter a vehicle name");
      return;
    }

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        final String uid = user.uid;

        // Create a subcollection named "vehicles" inside the user's document
        CollectionReference vehiclesCollection = _firestore
            .collection('AllUsers')
            .doc(phoneNo)
            .collection('vehicles');

        // Add a new document to the "vehicles" subcollection
        await vehiclesCollection.add({
          'name': vehicleName,
          'amount30Min': amount30,
          'amount120Min': amount120,
          'amountMoreThan120Min': amountMoreThan120,
          'adminId': phoneNo,
        });

        print('Subcollection document created successfully.');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PriceScreen(widget.phoneNo)));
      } else {
        print('User is not logged in.');
      }
    } catch (e) {
      print('Error creating subcollection document: $e');
    }
  }
}
