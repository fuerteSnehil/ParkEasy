// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:parkeasy/Screens/amountScreen.dart';
// import 'package:parkeasy/Screens/homeScreen.dart';
// import 'package:parkeasy/Utils/colors.dart';

// class AddVehicleScreen extends StatefulWidget {
//   const AddVehicleScreen({super.key});

//   @override
//   State<AddVehicleScreen> createState() => _AddVehicleScreenState();
// }

// class _AddVehicleScreenState extends State<AddVehicleScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final List<String> imageTitles = [
//       "Full Size Pickup",
//       "Mini Pickup",
//       "Mini Van",
//       "SUV",
//       "Utility Van",
//       "Crew Pickup",
//       "Full Size Pickup",
//       "Mini Bus",
//       "Van",
//       "Step Van",
//       "Utility Van",
//       "City Delivery",
//       "Mini Bus",
//       "Walk In",
//       "City Delivery",
//       "Conventional Van",
//       "Lanscape Utility",
//       "Large walk In",
//       "Bucket",
//       "City Delivery",
//       "Large Walk In",
//       "Bevrage",
//       "Rack",
//       "School Bus",
//       "Single Axle Van",
//       "Stake Body",
//       "City Transit Bus",
//       "Furniture",
//       "High Profile Semi",
//       "Home fuel",
//       "Medium Semi Tractor",
//       "Refuse",
//       "Tow",
//       "Cement Mixer",
//       "Dump",
//       "Fire Truck",
//       "Fuel",
//       "Heavy Semi Tractor",
//       "Refrigerated Van",
//       "Semi sleeper",
//       "Tour Bus",
//     ];

//     final List<String> assetImagePaths = [
//       "assets/Vehicle/one.png",
//       "assets/Vehicle/2.png",
//       "assets/Vehicle/3.png",
//       "assets/Vehicle/4.png",
//       "assets/Vehicle/5.png",
//       "assets/Vehicle/6.png",
//       "assets/Vehicle/7.png",
//       "assets/Vehicle/8.png",
//       "assets/Vehicle/9.png",
//       "assets/Vehicle/10.png",
//       "assets/Vehicle/11.png",
//       "assets/Vehicle/12.png",
//       "assets/Vehicle/13.png",
//       "assets/Vehicle/14.png",
//       "assets/Vehicle/15.png",
//       "assets/Vehicle/16.png",
//       "assets/Vehicle/17.png",
//       "assets/Vehicle/18.png",
//       "assets/Vehicle/19.png",
//       "assets/Vehicle/20.png",
//       "assets/Vehicle/21.png",
//       "assets/Vehicle/22.png",
//       "assets/Vehicle/23.png",
//       "assets/Vehicle/24.png",
//       "assets/Vehicle/25.png",
//       "assets/Vehicle/26.png",
//       "assets/Vehicle/27.png",
//       "assets/Vehicle/28.png",
//       "assets/Vehicle/29.png",
//       "assets/Vehicle/30.png",
//       "assets/Vehicle/31.png",
//       "assets/Vehicle/32.png",
//       "assets/Vehicle/33.png",
//       "assets/Vehicle/34.png",
//       // "assets/Vehicle/35.png",//repeated image
//       "assets/Vehicle/36.png",
//       "assets/Vehicle/37.png",
//       "assets/Vehicle/38.png",
//       "assets/Vehicle/39.png",
//       "assets/Vehicle/40.png",
//       "assets/Vehicle/41.png",
//       "assets/Vehicle/42.png",
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           color: Colors.black,
//           onPressed: () {
//             Navigator.pop(
//                 context, MaterialPageRoute(builder: (context) => HomeScreen(PhoneNo: '',)));
//           },
//         ),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           // Status bar color

//           statusBarColor: primaryColor,
//         ),
//         backgroundColor: primaryColor,
//         title: const Text(
//           "Add vehicle",
//           style: TextStyle(
//             color: Colors.black,
//             letterSpacing: 1,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3, // Number of columns in the grid
//         ),
//         itemCount: imageTitles.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               _handleItemTap(
//                   context, imageTitles[index], assetImagePaths[index]);
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Card(
//                 // color: Colors.amber.shade100,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                         assetImagePaths[index]), // Access image using index
//                     SizedBox(
//                       height: MediaQuery.of(context).size.width * 0.02,
//                     ),
//                     Text(imageTitles[index]), // Access title using index
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _handleItemTap(
//       BuildContext context, String tappedValue, String tappedimage) {
//     // Navigate to a new page and pass the tapped value
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AmmountScreen(
//             // tappedValue: tappedValue,
//             // tappedImage: tappedimage,
//             ),
//       ),
//     );
//   }
// }
