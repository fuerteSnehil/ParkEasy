import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Utils/colors.dart';

class VendorScreen extends StatefulWidget {
  final String uid;
  VendorScreen(this.uid);

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _deleteVendor(String phoneNumber) async {
    try {
      await firestore.collection('vendors').doc(phoneNumber).delete();
      Fluttertoast.showToast(
        msg: 'Vendor deleted successfully',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to delete vendor: $e',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginProvider ap = LoginProvider();
    return Scaffold(
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
                          PhoneNo: '',
                        )));
          },
        ),
        title: const AutoSizeText('Vendors',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: 1)),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('vendors').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                  color: Colors.black,
                ),
              );
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final vendorDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: vendorDocs.length,
              itemBuilder: (context, index) {
                final vendorData =
                    vendorDocs[index].data() as Map<String, dynamic>;
                final name = vendorData['name'];
                final phoneNumber = vendorData['phoneNumber'];

                return ListTile(
                  title: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Name:',
                        style: TextStyle(
                          color: Colors.black,
                        )),

                    TextSpan(
                        text: ' $name',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1))
                    // subtitle: Text('Phone No: $phoneNumber'),
                  ])),
                  subtitle: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Phone No:',
                        style: TextStyle(
                          color: Colors.black,
                        )),

                    TextSpan(
                        text: ' $phoneNumber',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                    // subtitle: Text('Phone No: $phoneNumber'),
                  ])),
                  // subtitle: Text('Phone No: $phoneNumber'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        // ignore: avoid_types_as_parameter_names
                        builder: (BuildContext) {
                          return Dialog(
                              // backgroundColor: Colors.amber.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      50.0)), //this right here
                              child: SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        "Are you sure ?",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor),
                                            child: const Text("Cancel",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              _deleteVendor(phoneNumber);
                                              Navigator.pop(context);
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
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
