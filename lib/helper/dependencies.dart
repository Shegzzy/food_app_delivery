import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/data/api_client.dart';
import 'package:food_delivery/data/repositories/popular_product_repo.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';

Future<void> init() async{
  //Api Client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //Product Repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  //Product Controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}