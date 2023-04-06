import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';

import 'big_text.dart';

class ProfileWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  ProfileWidget({Key? key, required this.bigText, required this.appIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(0, 3),
            color: Colors.grey.withOpacity(0.2),
          )
        ]
      ),
      padding: EdgeInsets.only(left: Dimensions.width15, top: Dimensions.height10, bottom: Dimensions.height10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText
        ],
      ),
    );
  }
}
