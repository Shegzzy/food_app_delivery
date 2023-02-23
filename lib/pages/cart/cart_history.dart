import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i<getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value)=>++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, ()=>1);
      }
    }
    List<int> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }

    List<int> orderTimes = cartOrderTimeToList();{
      //print(orderTimes);
    }
    var listCounter = 0;


    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: Dimensions.height120-20,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: AppColors.mainBlackColor,),
                SizedBox(width: Dimensions.width20),
                AppIcon(icon: Icons.shopping_cart_outlined, iconColor: AppColors.mainColor,)
              ],
            ),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for (int i = 0; i<orderTimes.length; i++)
                    Container(
                      height: Dimensions.height120,
                      margin: EdgeInsets.only(bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ((){
                            DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
                            var inputDate = DateTime.parse(parseDate.toString());
                            var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                            var outputDate = outputFormat.format(inputDate);
                            return BigText(text: outputDate, color: AppColors.mainBlackColor, size: Dimensions.font18-4,);
                          }()),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                children: List.generate(orderTimes[i], (index) {
                                  if(listCounter<getCartHistoryList.length){
                                    listCounter++;
                                  }
                                  return index<=2?Container(
                                    margin: EdgeInsets.only(right: Dimensions.height10-3),
                                    height: Dimensions.height45+25,
                                    width: Dimensions.height45+25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                        )
                                      )
                                    ),
                                  ): Container();
                                }),
                              ),
                              Container(
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallText(text: "Total", color: AppColors.mainBlackColor,),
                                    BigText(text: "${orderTimes[i]} Items", color: AppColors.mainBlackColor, size: Dimensions.font10+2,),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: Dimensions.width10, horizontal: Dimensions.height10/2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.height10/2),
                                        border: Border.all(width: 1, color: AppColors.mainColor),
                                      ),
                                      child: SmallText(text: "one more", color: AppColors.mainColor,),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
