import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loading.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/profile_widget.dart';
import 'package:get/get.dart';

import '../../widgets/big_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserData();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title:
          BigText(
            text: "Profile",
            size: Dimensions.font18+7,
            color: Colors.white,
          ),
      ),

      body: GetBuilder<UserController>(builder: (userController){
        //print(userController.userModel.name);
        return _userLoggedIn?(
            userController.isLoading?Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height10),
              child: Column(
                children: [
                  //Profile Photo
                  AppIcon(
                    icon: Icons.person,
                    size: Dimensions.height15*10,
                    backgroundColor: AppColors.mainColor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.height45+Dimensions.height45,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          //Profile name
                          ProfileWidget(
                            appIcon: AppIcon(
                              icon: Icons.person,
                              size: Dimensions.height10*3,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.icon24-4,
                            ),
                            bigText: BigText(
                              text: userController.userModel.name,
                              size: Dimensions.font18,

                            ),

                          ),

                          //Profile email
                          ProfileWidget(
                            appIcon: AppIcon(
                              icon: Icons.email_rounded,
                              size: Dimensions.height10*3,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.icon24-4,
                            ),
                            bigText: BigText(
                              text: userController.userModel.email,
                              size: Dimensions.font18,

                            ),

                          ),

                          //Profile phone
                          ProfileWidget(
                            appIcon: AppIcon(
                              icon: Icons.phone,
                              size: Dimensions.height10*3,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.icon24-4,
                            ),
                            bigText: BigText(
                              text: userController.userModel.phone,
                              size: Dimensions.font18,

                            ),

                          ),

                          //Profile address
                          ProfileWidget(
                            appIcon: AppIcon(
                              icon: Icons.location_pin,
                              size: Dimensions.height10*3,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.icon24-4,
                            ),
                            bigText: BigText(
                              text: "Address",
                              size: Dimensions.font18,

                            ),

                          ),

                          //Logout
                          ProfileWidget(
                            appIcon: AppIcon(
                              icon: Icons.settings,
                              size: Dimensions.height10*3,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.icon24-4,
                            ),
                            bigText: BigText(
                              text: "Settings",
                              size: Dimensions.font18,

                            ),

                          ),
                          GestureDetector(
                            onTap: (){
                              if(Get.find<AuthController>().userLoggedIn()){
                                Get.find<AuthController>().clearSharedData();
                                Get.offNamed(RouteHelper.getLoginPage());
                              }

                            },
                            child: ProfileWidget(
                              appIcon: AppIcon(
                                icon: Icons.logout_rounded,
                                size: Dimensions.height10*3,
                                backgroundColor: Colors.redAccent,
                                iconColor: Colors.white,
                                iconSize: Dimensions.icon24-4,
                              ),
                              bigText: BigText(
                                text: "Logout",
                                size: Dimensions.font18,

                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ):
            const CustomLoading()):
        Center(child: BigText(text: "Not Logged In"));
      }),
    );
  }
}
