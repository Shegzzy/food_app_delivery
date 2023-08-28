import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  final bool fromSignUpPage;
  final bool fromAddressPage;

  const MapPage({super.key,
    required this.fromSignUpPage,
    required this.fromAddressPage});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
