import 'dart:async';

import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Color(0xff10b981),
                ),
              ),
              SizedBox(height: 40,),
              Text("LOADING......",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color:Color(0xff10b981),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
