import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(45.51546, -122.34566), zoom: 17);
  late LatLng _initialPosition = const LatLng(45.51546, -122.34566);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserData();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));

      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Address Page"),
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),

      ),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';

          if(Get.find<LocationController>().addressList.isEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }

        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = '${locationController.placeMark.name??""}'
              '${
              locationController.placeMark.street ?? ""
          }'
              '${
              locationController.placeMark.locality ?? ""
          }'
              '${
              locationController.placeMark.postalCode ?? ""
          }'
              '${
              locationController.placeMark.country ?? ""
          }';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: Dimensions.height10-5, top: Dimensions.height10-5, right: Dimensions.height10-5, bottom: Dimensions.height10+5,),
                height: Dimensions.height120+20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 1,
                        color: AppColors.mainColor
                    )
                ),
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                      myLocationEnabled: true,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      onCameraMove: ((position)=> _cameraPosition=position),
                      onCameraIdle: (){
                        locationController.updatePosition(_cameraPosition, true);
                      },
                      onMapCreated: (GoogleMapController controller){
                        locationController.settingMapController(controller);
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                height: Dimensions.height20+20,
                width: double.maxFinite,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: locationController.addressTypeList.length,
                    itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      locationController.setAddressTypeIndex(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: Dimensions.width20),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15-10),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500]!,
                            spreadRadius: 1,
                            blurRadius: 5,
                          )
                        ]
                      ),
                      child: Icon(
                        index==0?Icons.home_filled:index==1?Icons.work:Icons.place,
                        color: locationController.addressTypeIndex == index?AppColors.mainColor:Theme.of(context).disabledColor,
                      ),
                    ),
                  );
                }),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Delivery Address
                        SizedBox(height: Dimensions.height15,),
                        BigText(text: "Delivery Address", size: Dimensions.font10+6,),
                        SizedBox(height: Dimensions.height10,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                    offset: const Offset(1, 1),
                                    color: Colors.grey.withOpacity(0.1)
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.radius15)

                          ),
                          child: TextField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              //prefixIcon
                              prefixIcon: Icon(Icons.map_sharp, color: AppColors.yellowColor,),

                              //focusedBorder
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.white
                                  )

                              ),

                              //enabledBorder
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.white
                                  )

                              ),

                              //border
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.radius15),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Dimensions.height15,),
                        BigText(text: "Name", size: Dimensions.font10+6,),
                        SizedBox(height: Dimensions.height10,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                    offset: const Offset(1, 1),
                                    color: Colors.grey.withOpacity(0.1)
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.radius15)

                          ),
                          child: TextField(
                            controller: _contactPersonName,
                            decoration: InputDecoration(
                              //prefixIcon
                              prefixIcon: Icon(Icons.person_4, color: AppColors.yellowColor,),

                              //focusedBorder
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.white
                                  )

                              ),

                              //enabledBorder
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.white
                                  )

                              ),

                              //border
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.radius15),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Dimensions.height15,),
                        BigText(text: "Phone Number", size: Dimensions.font10+6,),
                        SizedBox(height: Dimensions.height10,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                    offset: const Offset(1, 1),
                                    color: Colors.grey.withOpacity(0.1)
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.radius15)

                          ),
                          child: TextField(
                            controller: _contactPersonNumber,
                            decoration: InputDecoration(
                              //prefixIcon
                              prefixIcon: Icon(Icons.phone, color: AppColors.yellowColor, ),

                              //focusedBorder
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.white
                                  )

                              ),

                              //enabledBorder
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                                  borderSide: const BorderSide(
                                      width: 1.0,
                                      color: Colors.white
                                  )

                              ),

                              //border
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(Dimensions.radius15),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              )

            ],
          );
        });
      }),
    );
  }
}
