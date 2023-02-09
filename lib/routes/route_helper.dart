import 'package:food_delivery/pages/Food/popular_food_details.dart';
import 'package:food_delivery/pages/home/main_food_homepage.dart';
import 'package:get/get.dart';

import '../pages/Food/recommended_food_details.dart';
class RouteHelper{
  static const initial = "/";
  static const popularFood = "/popular-food";
  static const foodMenu = "/recommended-food";


  static String getPopularFood()=>'$popularFood';
  static String getFoodMenu()=>'$foodMenu';
  static String getInitial()=>'$initial';

  static List<GetPage> routes = [
    GetPage(name: initial, page: ()=> MainFoodPage()),
    GetPage(name: popularFood, page: () {
      return PopularFoodDetails();
    },
      transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: foodMenu, page: () {
      return RecommendedFoodDetails();
    },
        transition: Transition.rightToLeftWithFade
    ),
  ];
}