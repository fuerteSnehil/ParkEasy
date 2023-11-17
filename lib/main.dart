import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkeasy/Providers/login_provider.dart';
import 'package:parkeasy/Providers/provider.dart';
import 'package:parkeasy/Screens/splashScreen.dart';
import 'package:parkeasy/Utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor, // 1
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        )),
        home: const SplashScreen(),
      ),
    );
  }
}
