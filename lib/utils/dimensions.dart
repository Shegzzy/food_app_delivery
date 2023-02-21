import 'package:get/get.dart';

class Dimensions{
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //Dynamic screen sizes
  static double pageView = screenHeight/2.19;
  static double pageViewContainer = screenHeight/3.19;
  static double pageViewTextContainer = screenHeight/5.85;

  //Dynamic width for height and margin
  static double width10 = screenWidth/70.2;
  static double width15 = screenWidth/46.8;
  static double width20 = screenWidth/35.1;
  static double width30 = screenWidth/23.4;
  static double width45 = screenWidth/15.6;


  //Dynamic height for padding and margin
  static double height10 = screenHeight/70.2;
  static double height15 = screenHeight/46.8;
  static double height20 = screenHeight/35.1;
  static double height30 = screenHeight/23.4;
  static double height45 = screenHeight/15.6;
  static double height120 = screenHeight/5.85;

  //Dynamic font sizes
  //static double font20 = screenHeight/35.1;
  static double font18 = screenHeight/39;
  static double font10 = screenHeight/70.2;

  //Dynamic boderradius
  static double radius15 = screenHeight/46.8;
  static double radius20 = screenHeight/35.1;
  static double radius30 = screenHeight/23.4;

  //Iconsize
  static double icon24 = screenHeight/29.25;
  static double icon16 = screenHeight/43.87;

  //list view size
  static double listViewImgSize = screenHeight/7.02;
  static double listViewTextSize = screenHeight/7.02;

  //popular food
  static double popularFoodSize = screenHeight/2.0;

  // splash screen image
  static double splashImg = screenHeight/2.80;

}