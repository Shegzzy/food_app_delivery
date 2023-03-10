import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  const AppIcon({
    Key? key,
    required this.icon,
    this.iconColor =  const Color(0xFF756d54),
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.size=30
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        size: Dimensions.icon16,
        color: iconColor,
      ),
    );
  }
}
