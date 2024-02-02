import 'dart:async';
import 'package:firebase_ui/widget/route.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
    navigateToRoute();
    });
  }
  void navigateToRoute() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RouteA()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Rectangle 11898.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Centered Image at the Top
          Positioned(
            bottom: -80.0, // Adjust the bottom position as needed
            right: -40.0,
            child: Center(
              child: Image.asset(
                'assets/images/Ellipse 4.png', // Replace with your image path
                height: 300.0, // Set the desired height
                width: 300.0, // Set the desired width
              ),
            ),
          ),
          Positioned(
            top: -30.0, // Adjust the bottom position as needed
            left: -60.0,
            child: Center(
              child: Image.asset(
                'assets/images/Ellipse 3.png', // Replace with your image path
                height: 250.0, // Set the desired height
                width: 250.0, // Set the desired width
              ),
            ),
          ),

          // Centered Text in the Middle
          Center(
            child: Image.asset(
              'assets/images/H.png',
              height: 100,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
