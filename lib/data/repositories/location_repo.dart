import 'package:food_delivery/data/api_client.dart';
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

  String gettingUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }
}