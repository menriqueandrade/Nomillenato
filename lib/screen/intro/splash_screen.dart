// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget{
  static Widget  create(BuildContext context) => SplashScreen();

  @override
  Widget build(BuildContext context) {
   return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
   
            CircularProgressIndicator(),
            SizedBox(height: 24,),
            Text('Cargando', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
   );
  }
  
  
}