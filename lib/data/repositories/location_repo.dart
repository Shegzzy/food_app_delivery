import 'package:food_delivery/data/api_client.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({
    required this.sharedPreferences, required this.apiClient
});

  Future<Response> getAddressFromGeocode(LatLng latlng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latlng.latitude}&lng=${latlng.longitude}'
    );
  }

  Future<bool> saveUserAddress(String address) async{
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.APP_TOKEN)!);
    print("Saving: " + address);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  String gettingUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }

  Future<Response> addAddress(AddressModel addressModel) async{
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async{
    return await apiClient.getData(AppConstants.ADDRESSLIST_URI);
  }

  Future<Response> getUserZone(String lat, String lng) async{
    return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String location) async{
    return await apiClient.getData('${AppConstants.LOCATION_SEARCH_URI}?search_text=$location');
  }
}