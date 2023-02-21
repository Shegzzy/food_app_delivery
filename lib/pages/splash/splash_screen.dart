import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/product_menu_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  //Animation variables

  late Animation<double> animation;
  late AnimationController animationController;

  Future<void> _loadResources() async {
  await Get.find<PopularProductController>().getPopularProductList();
  await Get.find<ProductMenuController>().getProductMenuList();
}

  @override
  void initState(){
    _loadResources();
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: animationController, curve: Curves.linearToEaseOut);


    Timer(
      const Duration(seconds: 5),
        ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
                child:
                Image.asset("assets/image/logo1.jpg", width: Dimensions.splashImg,)

            ),
          ),
          /*          Center(
              child:
              Image.asset("assets/image/food.jpg", width: 200,)

          ),*/

        ],
      ),
    );
  }
}
