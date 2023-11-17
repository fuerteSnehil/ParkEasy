import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Providers/permission.dart';
import 'package:parkeasy/Providers/phone_authentication.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/otpScreen.dart';
import 'package:parkeasy/Utils/colors.dart';
import 'package:parkeasy/Utils/constants.dart';
import 'package:parkeasy/Utils/navigation.dart';
import 'package:parkeasy/Utils/utils.dart';
import 'package:parkeasy/widgets/custombtn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );
  late Navigation nav;
  Permissions permissions = Permissions();
  @override
  void initState() {
    nav = Navigation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final isLoading =
    //     Provider.of<AuthProvider>(context, listen: true).isLoading;
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    void _onLoading() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 150,
              width: 600,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularProgressIndicator(),
                  // new Text("Loading..."),
                  // new Image.asset(
                  //   'assets/loading2.gif',
                  //   height: 200,
                  // ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 35),
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/car.gif'),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),

                  // Container(
                  //   width: 100,
                  //   height: 100,
                  //   padding: const EdgeInsets.all(20.0),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Colors.amber.shade50,
                  //   ),
                  //   child: const Icon(
                  //     Icons.person_2_rounded,
                  //     size: 50,
                  //     color: Colors.amber,
                  //   ),
                  // ),

                  const Text(
                    "Login With Phone",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Add your phone number. We'll send you a verification code",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    cursorColor: Colors.amber,
                    controller: phoneController,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneController.text = value;
                      });
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    enableSuggestions: true,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                  context: context,
                                  countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 400,
                                  ),
                                  onSelect: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                    });
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                " + ${selectedCountry.phoneCode}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ),
                      suffixIcon: phoneController.text.length == 10
                          ? Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: amber,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.black,
                                size: 20,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Consumer<LoginProvider>(
                      builder: (context, value, _) => CustomButton(
                        backgroundColor: amber,
                        foregroundColor: black,
                        label: "Send OTP",
                        isLoading: value.isProcessing,
                        onTap: () async {
                          if (phoneController.text.length == 10) {
                            if (!(await permissions.checkSms())) {
                              await permissions.requestSms();
                            }
                            value.setPhone = "+91${phoneController.text}";
                            if (mounted) {
                              String result = await PhoneAuthentication(
                                context: context,
                                mounted: mounted,
                                lp: value,
                              ).sendPhoneOtp();
                              if (mounted) {
                                // showSnackBar(context, result);
                              }
                            }
                            Future.delayed(
                              const Duration(milliseconds: 1000),
                              () => nav.push(const OtpScreen()),
                            );
                          } else {
                            showSnackBar(
                              context,
                              "Incomplete phone number.",
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void sendPhoneNumber() {
  //   final ap = Provider.of<AuthProvider>(context, listen: false);
  //   String phoneNumber = phoneController.text.trim();
  //   ap.signInWithPhone(context, "+${selectedCountry.phoneCode}$phoneNumber");
  // }
}
