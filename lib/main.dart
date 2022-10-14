import 'package:blood_bank/providers/donor_provider.dart';
import 'package:blood_bank/providers/profile_provider.dart';
import 'package:blood_bank/screens/home_screen.dart';
import 'package:blood_bank/screens/splach_screen.dart';
import 'package:blood_bank/services/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((_) => DonorProvider()),
        ),
        ChangeNotifierProvider(
          create: ((_) => ProfileProvider()),
        ),
      ],
      child: MaterialApp(
      title: 'Blood Bank',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme(),
      home: SplachScreen(),
    ));
  }
}

