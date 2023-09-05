import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/data/repositories/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

import '../models/address_model.dart';
import '../models/response_model.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;

  LocationController({
    required this.locationRepo
});
  bool _inZone = false;
  bool get inZone => _inZone;
  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _loading = false;
  bool get loading => _loading;

  late Position _position;
  late Position _pickPosition;

  Position get position => _position;
  Position get pickPosition => _pickPosition;

  Placemark _placeMark = Placemark();
  Placemark _pickPlaceMark = Placemark();
  Placemark get placeMark => _placeMark;
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;


  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;


  final List<String> _addressTypeList=["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex=0;
  int get addressTypeIndex => _addressTypeIndex;


  late Map<String, dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

  bool _updateAddressData = true;
  bool _changeAddress = true;


  late GoogleMapController _mapController;
  GoogleMapController get googleMapController => _mapController;

  List<Prediction> _predictionList = [];


  void settingMapController(GoogleMapController mapController){
    _mapController=mapController;
  }

  // Updating position as user moves the map
  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if(_updateAddressData){
      _loading=true;
      update();
      try{
        if(fromAddress){
          _position=Position(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            heading: 1,
            speed: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            timestamp: DateTime.now()
          );
        }else{
          _pickPosition=Position(
              latitude: cameraPosition.target.latitude,
              longitude: cameraPosition.target.longitude,
              heading: 1,
              speed: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              timestamp: DateTime.now()
          );
        }

        ResponseModel _responseModel = await getZone(
            cameraPosition.target.latitude.toString(),
            cameraPosition.target.longitude.toString(),
            true
        );
        _buttonDisabled = !_responseModel.isSuccess;

        if(_changeAddress){
          String _address = await getAddressFromGeocode(
            LatLng(
              cameraPosition.target.latitude,
              cameraPosition.target.longitude,
            )
          );
          fromAddress? _placeMark = Placemark(name: _address):
              _pickPlaceMark = Placemark(name: _address);
        }
      }catch(e){
        print(e);
      }
      _loading=false;
      update();
    }else{
      _updateAddressData = true;
    }
  }

  Future<String> getAddressFromGeocode(LatLng latlng) async {
    String _address = "Unknown location found";
    Response response = await locationRepo.getAddressFromGeocode(latlng);
    if(response.body['status']=='OK'){
      _address = response.body["results"][0]['formatted_address'].toString();
      print("printing address: $_address");
    }else{
      print("Error getting api");
    }
    update();
    return _address;
  }

   AddressModel getUserAddress(){
    late AddressModel addressModel;
    // Converting to map using jsonDecode
    _getAddress = jsonDecode(locationRepo.gettingUserAddress());
    try{
      addressModel = AddressModel.fromJson(_getAddress);
    }catch(e){
      print(e);
    }
    return addressModel;
  }

  void setAddressTypeIndex(int index){
    _addressTypeIndex = index;
    update();
  }


  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if(response.statusCode==200){
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    }else{
      print("Address not saved");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    _loading=false;
    return responseModel;
  }

  Future<void> getAddressList() async{
    Response response = await locationRepo.getAllAddress();
    if(response.statusCode==200){
      _addressList=[];
      _allAddressList=[];
      response.body.forEach((address){
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    }else{
      _addressList=[];
      _allAddressList=[];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
   }

   void clearAddressList(){
     _addressList=[];
     _allAddressList=[];
     update();
   }

  String getUserAddressFromLocalStorage() {
    return locationRepo.gettingUserAddress();
  }

  void setAddressData(){
    _position=_pickPosition;
    _placeMark=_pickPlaceMark;
    _updateAddressData=false;
    update();
  }


  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async{
    late ResponseModel _responseModel;
    if(markerLoad){
      _loading = true;
    }else{
      _isLoading = true;
    }
    update();

    Response response = await locationRepo.getUserZone(lat, lng);
    if(response.statusCode == 200){
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone_id"].toString());
    }else{
      _inZone = false;
      _responseModel = ResponseModel(false, response.statusText!);
    }
      print("Zone: ${response.statusCode}");
    update();
    return _responseModel;
  }

  locationSearch(BuildContext context, String location) async {
    if(location.isNotEmpty){
      Response response = await locationRepo.searchLocation(location);
      if(response.statusCode==200 && response.body['status'] == 'OK'){
        _predictionList = [];
        response.body['predictions'].forEach((prediction) => _predictionList.add(Prediction.fromJson(prediction)));
      }else{

      }
    }
  }
}