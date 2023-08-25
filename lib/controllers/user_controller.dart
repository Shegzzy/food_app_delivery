import 'package:food_delivery/data/repositories/user_repo.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  //late UserModel _userModel;
  UserModel? _userModel;

  bool get isLoading => _isLoading;

  UserModel? get userModel => _userModel;

  Future<ResponseModel> getUserData() async {
    Response response = await userRepo.getUserData();
    late ResponseModel responseModel;
    //print(response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}