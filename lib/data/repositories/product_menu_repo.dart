import 'package:food_delivery/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class ProductMenuRepo extends GetxService{
  final ApiClient apiClient;

  ProductMenuRepo({required this.apiClient});

  Future<Response> getProductMenuList() async{
    return await apiClient.getData(AppConstants.PRODUCT_MENU_URI);
  }
}