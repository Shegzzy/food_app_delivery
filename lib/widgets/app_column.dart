import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,),
        SizedBox(height: Dimensions.height15,),
        Row(
          children: [
            Wrap(
                children: List.generate(5, (index) => Icon(Icons.star, color:AppColors.mainColor, size: 15),
                )
            ),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "4.5"),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "Rating"),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "1320")
          ],
        ),
        SizedBox(height: Dimensions.height15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconTextWidget(icon: Icons.circle_sharp, size: Dimensions.icon24,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconTextWidget(icon: Icons.location_city, size: Dimensions.icon24,
                text: "Service",
                iconColor: AppColors.iconColor2),
            IconTextWidget(icon: Icons.access_time_rounded, size: Dimensions.icon24,
                text: "8AM - 8PM",
                iconColor: AppColors.iconColor2)
          ],
        ),
      ],
    );
  }
}
