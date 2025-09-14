import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        color: Color(0xff10b981),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png",height: 200,width: 200,),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Product",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 10,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
              ),
            ),Center(
              child: Text(
                "Authenticy",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 10,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
              ),
            ),Center(
              child: Text(
                "Checker",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 10,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}