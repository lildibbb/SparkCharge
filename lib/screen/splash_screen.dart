import 'dart:async';
import 'package:flutter/material.dart';
import 'package:individual_mobile/screen/dashboard.dart';
import 'package:individual_mobile/utils/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Dashboard after a 3-second delay
    Timer(const Duration(seconds: 3), () {
      _navigateToDashboard();
    });
  }

  void _navigateToDashboard() {
    try {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Dashboard(title: 'SparkCharge')),
      );
    } catch (e) {
      // Handle navigation error if any
      print('Navigation Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image(image: AssetImage(Assets.logoApp)),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
