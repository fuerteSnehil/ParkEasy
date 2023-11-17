import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Utils/colors.dart';

class PriceScreen extends StatefulWidget {
  final String uid;

  PriceScreen(this.uid);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // final Map<String, String> imageMap = {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          PhoneNo: widget.uid,
                        )));
          },
        ),
        title: const Text(
          'Vehicle Pricing',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('AllUsers')
              .doc(widget.uid)
              .collection('vehicles')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: Colors.black,
                ),
              );
            }

            final documents = snapshot.data!.docs;

            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
                indent: 40,
                endIndent: 40,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final vehicleName = document['name'];
                final amount30Min = document['amount30Min'];
                final amount120Min = document['amount120Min'];
                final amountMoreThan120Min = document['amountMoreThan120Min'];

                return ListTile(
                  title: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Vehicle name:',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        )),

                    TextSpan(
                        text: ' $vehicleName',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            letterSpacing: 1))
                    // subtitle: Text('Phone No: $phoneNumber'),
                  ])),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Charges for 30min:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            )),

                        TextSpan(
                            text: ' $amount30Min₹',
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 1))
                        // subtitle: Text('Phone No: $phoneNumber'),
                      ])),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Charges for 120min:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            )),

                        TextSpan(
                            text: ' $amount120Min₹',
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 1))
                        // subtitle: Text('Phone No: $phoneNumber'),
                      ])),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Charges after every hour of 120 min:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            )),

                        TextSpan(
                            text: ' $amountMoreThan120Min₹',
                            style: TextStyle(
                                color: Colors.black,
                                // fontWeight: FontWeight.bold,
                                fontSize: 17,
                                letterSpacing: 1))
                        // subtitle: Text('Phone No: $phoneNumber'),
                      ])),
                    ],
                  ),
                  trailing: IconButton(
                    color: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
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
                                              firestore
                                                  .collection('AllUsers')
                                                  .doc(widget.uid)
                                                  .collection('vehicles')
                                                  .doc(document
                                                      .id) // document.id represents the document ID
                                                  .delete()
                                                  .then((_) {
                                                Fluttertoast.showToast(
                                                  msg: "Deleted Successfully",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 2,
                                                  backgroundColor: primaryColor,
                                                  textColor: Colors.black,
                                                  fontSize: 16.0,
                                                );
                                              }).catchError((error) {
                                                print(
                                                    'Error deleting document: $error');
                                              });
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
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteVehicle(DocumentReference vehicleRef) async {
    try {
      await vehicleRef.delete();
      print('Vehicle deleted successfully');
    } catch (e) {
      print('Error deleting vehicle: $e');
    }
  }
}
