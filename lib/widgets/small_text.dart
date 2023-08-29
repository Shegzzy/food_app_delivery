import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';


class SmallText extends StatelessWidget {
  TextStyle? style;
  Color? color;
  final String text;
  double size;
  double height;

  SmallText({Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size=0,
    this.height=1.2,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: size==0?Dimensions.font10:size,
          height: height,
          color: color,
          fontWeight: FontWeight.w400
      ),
    );
  }
}
