import 'package:contact_app/halaman1.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(primaryColor: Colors.white,
          scaffoldBackgroundColor: MainGreyMainBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HalamanSatu(),
    );
  }
}
