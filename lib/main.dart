import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'onboarding.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'CashClicks',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: const Text('CASHCLICKS.',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
        nextScreen: const Onboarding(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.deepPurple,

      )
    );
  }
}
