import 'package:flutter/material.dart';
import 'package:food_delivery/pages/Food/popular_food_details.dart';
import 'package:food_delivery/pages/home/main_food_homepage.dart';

import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PopularFoodDetails(),
    );
  }
}
