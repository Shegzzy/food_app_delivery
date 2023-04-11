import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_menu_controller.dart';
import 'package:food_delivery/pages/Food/recommended_food_details.dart';
import 'package:food_delivery/pages/home/main_food_homepage.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'helper/dependencies.dart' as dep;
import 'package:get/get.dart';

import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    // Initializing the controllers
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<ProductMenuController>(builder: (_){
        return GetBuilder<CartController>(builder: (_){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            //home: MainFoodPage(),
            initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
          );
        });
      });
    });
  }
}
