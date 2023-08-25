import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_homepage.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';


class PopularFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),
              )
          ),
          //icons widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        if(page == "cartpage"){
                          Get.toNamed(RouteHelper.cartPage);
                        }else{
                          Get.toNamed(RouteHelper.initial);
                        }
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios)),

                  GetBuilder<PopularProductController>(builder: (controller){
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getCartPage());
                            },
                            child: const AppIcon(icon: Icons.shopping_cart_outlined)),
                        controller.totalItems >= 1 ?
                          Positioned(
                              right:0,
                              top:0,
                              child: AppIcon(icon: Icons.circle, size: 15, backgroundColor: AppColors.mainColor, iconColor:Colors.transparent)):
                            Container(),
                        controller.totalItems >= 1 ?
                        Positioned(
                            right:4,
                            top:1,
                            child:
                            BigText(text: controller.totalItems.toString(), size: 12, color: Colors.white,)
                        ):
                        Container()
                      ],
                    );
                  })
                ],
              )
          ),
          //about food
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodSize-62,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius15),
                    topRight: Radius.circular(Dimensions.radius15),
                  ),
                  color: Colors.white70
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name,),
                    SizedBox(height: Dimensions.height10,),
                    BigText(text: "Introduction"),
                    SizedBox(height: Dimensions.height10,),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableText(
                                text: product.description!)))
                  ],
                )
              )
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (productController){
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
          child: Row(
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
                    GestureDetector(
                        onTap: (){
                          productController.setQuantity(false);
                        },
                        child: AppIcon(icon: Icons.remove,
                          iconColor: AppColors.signColor,
                          backgroundColor: AppColors.mainColor,)),
                    SizedBox(width: Dimensions.width15,),
                    BigText(text: productController.inCartItems.toString()),
                    SizedBox(width: Dimensions.width15,),
                    GestureDetector(
                      onTap: (){
                        productController.setQuantity(true);
                      },
                        child: AppIcon(icon: Icons.add, iconColor: AppColors.signColor, backgroundColor: AppColors.mainColor,)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  productController.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.height10, bottom: Dimensions.height10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                  child: BigText(text: "\$ ${product.price!} Add to cart", color: Colors.white,),
                ),
              ),
            ],
          ),
        );
      })
    );
  }
}
