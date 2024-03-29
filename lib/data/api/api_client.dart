import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../base/custom_message.dart';
import '../../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token=sharedPreferences.getString(AppConstants.APP_TOKEN)??"";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'HttpHeaders.contentTypeHeader': 'application/json'
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'HttpHeaders.contentTypeHeader': 'application/json'
    };
  }

    // Request for getting data from api server
    Future<Response> getData(String uri, {Map<String, String>? headers}) async{
      try{
        Response response = await get(uri, headers: headers??_mainHeaders);
        // print(response.body.toString());
        return response;
      }catch(e){
        return Response(statusCode: 1, statusText: e.toString());
      }
    }

    //Request for posting data to the api server
    Future<Response> postData(String uri, dynamic body) async{
    print(body.toString());
      try{
        Response response = await post(uri, body, headers: _mainHeaders);
        // print(response.toString());
        return response;
      }catch(e){
        customSnackBar(e.toString(), title: "Error");
        return Response(statusCode: 1, statusText: e.toString());
      }

    }
}