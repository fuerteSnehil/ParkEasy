// import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Providers/phone_authentication.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/homeScreen.dart';
import 'package:parkeasy/Screens/phoneNoScreen.dart';
import 'package:parkeasy/Screens/registerScreen.dart';
import 'package:parkeasy/Utils/colors.dart';
import 'package:parkeasy/Utils/constants.dart';
import 'package:parkeasy/Utils/navigation.dart';
import 'package:parkeasy/Utils/utils.dart';
import 'package:parkeasy/widgets/custombtn.dart';
import 'package:parkeasy/widgets/screen.dart';
import 'package:provider/provider.dart';

// import 'home.dart';

class OtpScreen extends StatefulWidget {
  // final String verificationId;
  // final String myPhone;

  const OtpScreen({
    super.key,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController phoneController = TextEditingController();
  String? otpCode;
  late Navigation nav;

  @override
  void initState() {
    nav = Navigation(context);
    super.initState();
  }

  goBack() {
    if (mounted) {
      nav.pushAndRemoveUntil(const LoginScreen());
      Provider.of<LoginProvider>(context, listen: false).reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<LoginProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: white,
        iconTheme: const IconThemeData(color: black),
        leading: IconButton(
          onPressed: () => goBack(),
          icon: Icon(MdiIcons.arrowLeft),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: Consumer<LoginProvider>(
        builder: (context, lp, _) => Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/man.gif", scale: 2),
              Text(
                "We have sent the verification code to your mobile number",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      height: 1.10,
                    ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lp.phone,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    GestureDetector(
                      onTap: () => goBack(),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          MdiIcons.pencilCircle,
                          color: black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  otpBox(
                    lp.controllers[0],
                    focusNode: lp.firstFocusNode,
                  ),
                  otpBox(lp.controllers[1]),
                  otpBox(lp.controllers[2]),
                  otpBox(lp.controllers[3]),
                  otpBox(lp.controllers[4]),
                  otpBox(
                    lp.controllers[5],
                    isLast: true,
                    focusNode: lp.lastFocusNode,
                  ),
                ],
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  for (TextEditingController controller in lp.controllers) {
                    controller.clear();
                  }
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(lp.firstFocusNode);
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Clear",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: black),
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                isLoading: lp.isProcessing,
                foregroundColor: black,
                label: "Verify OTP",
                // backgroundColor: theme,
                backgroundColor: amber,
                borderRadius: 500,
                onTap: () async {
                  String result = await PhoneAuthentication(
                    context: context,
                    mounted: mounted,
                    lp: lp,
                  ).verifyPhoneOTP();

                  if (mounted) {
                    showSnackBar(context, result);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded otpBox(
    TextEditingController controller, {
    bool? isLast,
    FocusNode? focusNode,
  }) {
    Screen s = Screen(context);
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 12 * s.customWidth),
        child: TextField(
          focusNode: focusNode,
          autofocus: true,
          autofillHints: const [
            AutofillHints.oneTimeCode,
          ],
          style: Theme.of(context).textTheme.headlineSmall,
          controller: controller,
          cursorColor: black,
          onChanged: (value) {
            if (value.isNotEmpty) {
              controller.text = value[value.length - 1];
              if (!(isLast ?? false)) {
                FocusScope.of(context).nextFocus();
              } else {
                FocusScope.of(context).unfocus();
              }
            }
          },
          onTap: () {
            controller.clear();
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            // LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10 * s.customWidth),
            border: border(),
            enabledBorder: border(),
            focusedBorder: border(color: black),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: color ?? grey,
        width: color == null ? 1 : 2,
      ),
    );
  }
}
