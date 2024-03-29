import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repositories/auth_repo.dart';
import 'package:food_delivery/data/repositories/cart_repo.dart';
import 'package:food_delivery/data/repositories/location_repo.dart';
import 'package:food_delivery/data/repositories/popular_product_repo.dart';
import 'package:food_delivery/data/repositories/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/product_menu_controller.dart';
import '../controllers/user_controller.dart';
import '../data/repositories/product_menu_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(()=> sharedPreferences);

  //Api Client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //Auth Repo
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //Location Repo
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  //User Repo
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));

  //Auth Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));

  //Location Controller
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));

  //User Controller
  Get.lazyPut(() => UserController(userRepo: Get.find()));

  //Product Repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProductMenuRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

  //Product Controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => ProductMenuController(productMenuRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}