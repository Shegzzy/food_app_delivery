import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';

import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getCartHistory());
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios_new_rounded,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,),
                    ),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getInitial());
                          },
                          child: AppIcon(
                            icon: Icons.home_sharp,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,),
                        ),
                      ],
                    )


                  ],
                )),
            Positioned(
                top: Dimensions.height45+45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (_, index){
                            return SizedBox(
                              height: Dimensions.height20*5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  Container(
                                      height: Dimensions.height120-20,
                                      width: Dimensions.height120-20,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartList[index].img!
                                            )
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                                      ),
                                    ),

                                  SizedBox(width: Dimensions.width10,),
                                  Expanded(
                                      child: SizedBox(
                                        height: Dimensions.height20*5,

                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BigText(text: cartList[index].name!, color: Colors.black54,),
                                            SmallText(text: "Fried Tasty Chicken"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: "\$${cartList[index].price}", size: Dimensions.font10+5,),
                                                Container(
                                                  padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.height10, bottom: Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius15),

                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                ))
          ],
        ),
    );
  }
}
