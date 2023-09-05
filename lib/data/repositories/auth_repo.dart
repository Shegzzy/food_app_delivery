import 'package:food_delivery/base/custom_message.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  
  Future<Response> registration(SignUpModel signUpModel) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpModel.toJson());
  }

  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI,
        {"phone":phone, "password":password});
  }

  //Save token/user date to local storage
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.APP_TOKEN, token);
  }

  Future<String> getUserToken() async{
    return await sharedPreferences.getString(AppConstants.APP_TOKEN)??"None";
  }

  //Check if user has been signed in before
  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.APP_TOKEN);
  }

  //Logout by clearing user data from local storage
  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.APP_TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }

  //saving user's login credentials locally
  Future<void> saveUserNumberAndPassword(String number, String password) async{
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);

    }catch(e){
      customSnackBar(e.toString(), title: "Error");
    }
  }
}