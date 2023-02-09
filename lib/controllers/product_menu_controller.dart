import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../data/repositories/product_menu_repo.dart';
import '../models/products_model.dart';

class ProductMenuController extends GetxController{
  final ProductMenuRepo productMenuRepo;
  ProductMenuController({required this.productMenuRepo});

  List<dynamic> _productMenuList=[];
  List<dynamic> get productMenuList => _productMenuList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getProductMenuList() async{
    Response response = await productMenuRepo.getProductMenuList();
    if(response.statusCode==200){
      _productMenuList=[];
      _productMenuList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }else{

    }
  }
}