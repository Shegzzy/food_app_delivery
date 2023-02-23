import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
import '../../utils/app_constants.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList){
    // sharedPreferences.remove(AppConstants.CART_HISTORY);
    // sharedPreferences.remove(AppConstants.CART_LIST);
    var time = DateTime.now().toString();
    cart = [];
    //converting objects of (CartModel) to string because sharedpreference accepts only strings use jsonEncode (these two are the same)

    /*
        cartList.forEach((element) {
          return cart.add(jsonEncode(element));
        });
    */
    cartList.forEach((element){
      element.time =time;
      return cart.add(jsonEncode(element));
    }
    );

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    //getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("inside getcartlist"+carts.toString());
    }
    List<CartModel> cartList=[];

    //converting String to object we use jsonDecode from (fromJson function)
    carts.forEach((element)=> cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }

    List<CartModel> cartListHistory = [];
      cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
      return cartListHistory;

  }

  void addToCartHistory(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory=[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    for(int i =0; i<cart.length; i++){
      print("History List "+cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY, cartHistory);
    print("Still in memory"+getCartHistoryList().length.toString());

    for(int j = 0; j<getCartHistoryList().length; j++){
      print("Order Time is "+getCartHistoryList()[j].time.toString());
    }
  }

  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

}