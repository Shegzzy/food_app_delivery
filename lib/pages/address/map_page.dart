import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/location_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';

class MapPage extends StatefulWidget {
  final bool fromSignUpPage;
  final bool fromAddressPage;
  final GoogleMapController? mapController;

  const MapPage({super.key,
    required this.fromSignUpPage,
    required this.fromAddressPage,
    this.mapController});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng _initialPosition;
  late GoogleMapController _googleMapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = LatLng(45.531, -122.677433);
      _cameraPosition=CameraPosition(target: _initialPosition, zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition = LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]), double.parse(Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                  initialCameraPosition: CameraPosition(
                  target: _initialPosition, zoom: 17
              ),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition){
                    _cameraPosition = cameraPosition;
                  },
                  indoorViewEnabled: true,
                  myLocationEnabled: true,
                  onCameraIdle: (){
                    Get.find<LocationController>().updatePosition(_cameraPosition, false);
                  }
              ),
              Center(
                child: !locationController.loading?Image.asset(
                    "assets/image/place_picker.png",
                    width: 85, height: 85,
                ):
                CircularProgressIndicator(),
              ),
              Positioned(
                  top: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20+45,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                    height: Dimensions.height30,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius15-5)
                    ),
                    child: Row(
                      children: [
                        AppIcon(
                          icon: Icons.place,
                          iconColor: AppColors.yellowColor,
                          iconSize: Dimensions.icon16,
                          backgroundColor: AppColors.paraColor,
                          size: Dimensions.width20*2,
                        ),
                        SizedBox(width: Dimensions.width10,),
                        Expanded(
                            child: Text(
                              locationController.pickPlaceMark.name??"",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Roboto'
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      );
    });
  }
}
