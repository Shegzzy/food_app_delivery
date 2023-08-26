import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_menu_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //header
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      //Get.toNamed(RouteHelper.getInitial());
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
                      SizedBox(width: Dimensions.width45+5,),
                      AppIcon(
                        icon: Icons.shopping_cart,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,)
                    ],
                  )


                ],
              )),
          //body
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
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
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index){
                            return SizedBox(
                              height: Dimensions.height20*5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    // Finding food categories from cart page
                                    onTap: (){
                                      var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product!);
                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));
                                      }else{
                                        var menuIndex = Get.find<ProductMenuController>().productMenuList.indexOf(_cartList[index].product!);
                                        Get.toNamed(RouteHelper.getFoodMenu(menuIndex, "cartpage"));
                                      }
                                    },
                                    child: Container(
                                      height: Dimensions.height120-20,
                                      width: Dimensions.height120-20,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + _cartList[index].img!
                                            )
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                                      ),
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
                                            BigText(text: _cartList[index].name!, color: Colors.black54,),
                                            SmallText(text: "Fried Tasty Chicken"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: "\$${_cartList[index].price}"),
                                                Container(
                                                  padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.height10, bottom: Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius15),

                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: (){
                                                            cartController.addItems(_cartList[index].product!, -1);
                                                          },
                                                          child: AppIcon(
                                                            icon: Icons.remove,
                                                            iconColor: AppColors.signColor,
                                                            backgroundColor: AppColors.mainColor,
                                                            size: Dimensions.icon24,
                                                          )),
                                                      SizedBox(width: Dimensions.width15,),
                                                      BigText(text: _cartList[index].quantity!.toString(), size: Dimensions.font10+6,), //text: productController.inCartItems.toString()),
                                                      SizedBox(width: Dimensions.width15,),
                                                      GestureDetector(
                                                          onTap: (){
                                                            cartController.addItems(_cartList[index].product!, 1);
                                                          },
                                                          child: AppIcon(
                                                            icon: Icons.add,
                                                            iconColor: AppColors.signColor,
                                                            backgroundColor: AppColors.mainColor,
                                                            size: Dimensions.icon24,
                                                          )),
                                                    ],
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
                )):
            const NoDataPage(text: "Your Cart is Empty!!!");
          }
          )
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: Dimensions.height120,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30),

                )
            ),
            child: cartController.getItems.length>0?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.height10, bottom: Dimensions.height10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.width15,),
                      BigText(text: "\$${cartController.totalAmount}"),
                      SizedBox(width: Dimensions.width15,),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    //cartController.addToHistory();
                    if(Get.find<AuthController>().userLoggedIn()){

                      if(Get.find<LocationController>().addressList.isEmpty){
                        Get.toNamed(RouteHelper.getAddressPage());

                      }
                    }else{
                      Get.toNamed(RouteHelper.getLoginPage());
                    }

                  },
                  child: Container(
                    padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.height10, bottom: Dimensions.height10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15-5),
                      color: Colors.deepOrangeAccent,
                    ),
                    child: BigText(text: "Check Out", color: Colors.white,),
                  ),
                ),
              ],
            ):
                Container()
          );
        })

    );
  }
}
