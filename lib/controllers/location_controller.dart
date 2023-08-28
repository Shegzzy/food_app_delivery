import 'dart:convert';

import 'package:food_delivery/data/repositories/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';
import '../models/response_model.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;

  LocationController({
    required this.locationRepo
});
  bool _loading = false;
  bool get loading => _loading;

  late Position _position;
  late Position _pickPosition;

  Placemark _placeMark = Placemark();
  Placemark _pickPlaceMark = Placemark();
  Placemark get placeMark => _placeMark;
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;


  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList => _allAddressList;


  List<String> _addressTypeList=["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;

  int _addressTypeIndex=0;
  int get addressTypeIndex => _addressTypeIndex;


  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  bool _updateAddressData = true;
  bool _changeAddress = true;


  Position get position => _position;
  Position get pickPosition => _pickPosition;


  late GoogleMapController _mapController;
  GoogleMapController get googleMapController => _mapController;


  void settingMapController(GoogleMapController mapController){
    _mapController=mapController;
  }

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



}