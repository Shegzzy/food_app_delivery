import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_menu_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/Food/popular_food_details.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.88);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?SizedBox(
            height: Dimensions.pageView,

              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),

          ):
          CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //Dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        SizedBox(height: Dimensions.height20,),

        // Food List Heading
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Our Menu"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),

              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: SmallText(text: "Food Pairing",),
              )
            ],
          ),
        ),


        //Food Menu List
        GetBuilder<ProductMenuController>(builder: (productMenu){
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productMenu.productMenuList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getFoodMenu(index, "home"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width30/2, right: Dimensions.width30/2, bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        //Image container
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${AppConstants.BASE_URL+AppConstants.UPLOAD_URL}${productMenu.productMenuList[index].img!}"
                                  )
                              )

                          ),
                        ),

                        //Text container
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextSize,
                            decoration: const BoxDecoration(
                              color: Colors.white70,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: productMenu.productMenuList[index].name!),
                                  SizedBox(height: Dimensions.height10,),
                                  SmallText(text: "Fried chicken with catchup's"),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconTextWidget(icon: Icons.circle_sharp, size: Dimensions.icon16,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      IconTextWidget(icon: Icons.location_city, size: Dimensions.icon16,
                                          text: "Service",
                                          iconColor: AppColors.iconColor2),
                                      IconTextWidget(icon: Icons.access_time_rounded, size: Dimensions.icon16,
                                          text: "8AM - 8PM",
                                          iconColor: AppColors.iconColor2)
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                );
              }

          );
        })

      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = Matrix4.identity();
    if(index==_currentPageValue.floor()){
      var currScale = 1 - (_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if(index == _currentPageValue.floor()+1){
      var currScale = _scaleFactor + (_currentPageValue - index+1)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currentPageValue.floor()-1){
      var currScale = 1 - (_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven?const Color(0xFF69c5df):const Color(0xFF9294cc),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 2.5,
                        offset: Offset(0, 5)
                    )
                  ],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "${AppConstants.BASE_URL+AppConstants.UPLOAD_URL}${popularProduct.img!}"
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30+5, right: Dimensions.width30+5, bottom: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 0.5,
                    offset: Offset(0, 5)
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0)
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0)
                  )
                ]

              ),
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,top: Dimensions.height15, bottom: Dimensions.height10-2),
                child: AppColumn(text: popularProduct.name!)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
