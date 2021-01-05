import 'package:flutter/material.dart';
import 'package:helloworld/Pages/home.dart';
import 'package:helloworld/Pages/loading.dart';
import 'package:helloworld/Pages/location.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
  },
));
