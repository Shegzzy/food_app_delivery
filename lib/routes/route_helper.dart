import 'package:food_delivery/pages/Food/popular_food_details.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/cart/cart_history_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_homepage.dart';
import 'package:food_delivery/pages/login/login_page.dart';
import 'package:food_delivery/pages/sign_up/sign_up_page.dart';
import 'package:food_delivery/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../pages/Food/recommended_food_details.dart';
class RouteHelper{
  static const initial = "/";
  static const loginPage = "/login-page";
  static const signUpPage = "/signup-page";
  static const popularFood = "/popular-food";
  static const foodMenu = "/recommended-food";
  static const cartPage = "/cart-page";
  static const historyPage = "/history-page";
  static const cartHistory = "/cart-history";
  static const splashScreen = "/splash-screen";


  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getFoodMenu(int pageId, String page)=>'$foodMenu?pageId=$pageId&page=$page';
  static String getCartPage()=> cartPage;
  static String getCartHistory()=> cartHistory;
  static String getHistoryPage()=> historyPage;
  static String getSplashScreen()=> splashScreen;
  static String getLoginPage()=> loginPage;
  static String getSignUpPage()=> signUpPage;
  static String getInitial()=>initial;

  static List<GetPage> routes = [
    //GetPage(name: splashScreen, page: ()=> const SplashScreen()),
    //GetPage(name: signUpPage, page: ()=> const SignUpPage()),
    //GetPage(name: loginPage, page: ()=> const LoginPage()),
    //GetPage(name: initial, page: ()=> const HomePage()),

    GetPage(name: splashScreen, page: (){
      return const SplashScreen();
    },
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: initial, page: (){
      return const HomePage();
    },
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return PopularFoodDetails(pageId:int.parse(pageId!), page:page!);
    },

      transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: foodMenu, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return RecommendedFoodDetails(pageId:int.parse(pageId!), page:page!);
    },
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: signUpPage, page: (){
      return const SignUpPage();
    },
        transition: Transition.rightToLeftWithFade
    ),


    GetPage(name: loginPage, page: (){
      return const LoginPage();
    },
        transition: Transition.rightToLeftWithFade
    ),
    
    GetPage(name: cartPage, page: (){
      return const CartPage();
    },
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: historyPage, page: (){
      return const HistoryPage();
    },
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: cartHistory, page: (){
      return const CartHistory();
    },
        transition: Transition.rightToLeftWithFade
    )
  ];
}