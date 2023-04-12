import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

import '../api_client.dart';

class UserRepo{
  final ApiClient apiClient;

  UserRepo({
    required this.apiClient
});

  Future<Response> getUserData() async{
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}