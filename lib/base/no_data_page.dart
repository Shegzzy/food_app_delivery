import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage({Key? key, required this.text, this.imgPath = "assets/image/empty-cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          height: MediaQuery.of(context).size.height*0.22,
          width: MediaQuery.of(context).size.width*0.22,
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03),
        Text(
            text,
          style: TextStyle(
            /*fontSize: Dimensions.font10+5,
            color: AppColors.mainColor,*/
            fontSize: MediaQuery.of(context).size.height*0.0175,
            color: Theme.of(context).disabledColor,

          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
