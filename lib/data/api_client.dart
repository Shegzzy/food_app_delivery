import 'package:get/get.dart';

import '../base/custom_message.dart';
import '../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token=AppConstants.APP_TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

// Request for getting data from server
    Future<Response> getData(String uri,) async{
      try{
        Response response = await get(uri);
        return response;
      }catch(e){
        return Response(statusCode: 1, statusText: e.toString());
      }
    }

    //Request for posting data to the server
    Future<Response> postData(String uri, dynamic body) async{
    //print(body.toString());
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