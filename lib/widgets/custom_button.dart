import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  const CustomButton({super.key,
    this.onPressed,
    required this.buttonText,
    this.transparent=false,
    this.margin,
    this.width=200,
    this.height,
    this.fontSize,
    this.radius=10,
    this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButton = TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:
      transparent?Colors.transparent:AppColors.mainColor,
      minimumSize: Size(
          width==null?Dimensions.screenWidth:width!,
          height??Dimensions.height45),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      )
    );
    return Center(
      child: SizedBox(
        width: width==null?width!:Dimensions.screenWidth,
        height: height?? Dimensions.height45,
        child: TextButton(
          onPressed: onPressed,
          style: flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!=null?Padding(
                  padding: EdgeInsets.only(right: Dimensions.width10),
                  child: Icon(icon, color: transparent?AppColors.mainColor:
                  Theme.of(context).cardColor),
              ):const SizedBox(),
              Text(
                buttonText, style: TextStyle(
                fontSize: fontSize ?? Dimensions.font10+5,
                color: transparent?AppColors.mainColor:
                Theme.of(context).cardColor)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
