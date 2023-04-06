
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/product_menu_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductMenuController>().productMenuList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: Dimensions.height30+40,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      if(page == "cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());

                      }
                    },
                  child: const AppIcon(icon: Icons.clear_sharp),
                ),
                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getCartPage());
                          },
                          child: const AppIcon(icon: Icons.shopping_cart_outlined)),
                      Get.find<PopularProductController>().totalItems >= 1 ?
                      Positioned(
                          right:0,
                          top:0,
                          child: AppIcon(icon: Icons.circle, size: 15, backgroundColor: AppColors.mainColor, iconColor:Colors.transparent)):
                      Container(),
                      Get.find<PopularProductController>().totalItems >= 1 ?
                      Positioned(
                          right:4,
                          top:1,
                          child:
                          BigText(text: Get.find<PopularProductController>().totalItems.toString(), size: 12, color: Colors.white,)
                      ):
                      Container()
                    ],
                  );
                })              ],
            ),
            bottom: PreferredSize(preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: Dimensions.height10-5, bottom: Dimensions.height10-5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius15),
                    topRight: Radius.circular(Dimensions.radius15),
                  )
                ),
                child: Center(
                  child: BigText(text: product.name!)
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img,
                  width: double.maxFinite,
                  fit: BoxFit.cover,

              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                  child: ExpandableText(
                      text: product.description!
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width45+5,
                  right: Dimensions.width45+5,
                  top: Dimensions.height15,
                  bottom: Dimensions.height15
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(icon: Icons.remove, iconColor: Colors.black54, backgroundColor: AppColors.mainColor),
                  ),
                  BigText(text: "\$${product.price!} X ${controller.inCartItems} "),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(icon: Icons.add, iconColor: Colors.black54, backgroundColor: AppColors.mainColor),
                  )
                ],
              ),
            ),
            Container(
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
                      width: Dimensions.height45-5,
                      height: Dimensions.height45-5,
                      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, top: Dimensions.height10, bottom: Dimensions.height10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite_sharp,
                        color: AppColors.mainColor,
                        size: Dimensions.icon24,
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.height10, bottom: Dimensions.height10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                      child: Row(
                        children: [
                          BigText(text: "\$${product.price!} Add to cart", color: Colors.white,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
