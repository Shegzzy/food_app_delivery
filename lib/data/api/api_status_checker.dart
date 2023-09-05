import 'package:food_delivery/base/custom_message.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker{

  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(RouteHelper.signUpPage);
      customSnackBar("Please sign in first");
    }else{
      customSnackBar(response.statusText!);
    }
  }
}