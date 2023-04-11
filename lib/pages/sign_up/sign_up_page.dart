import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loading.dart';
import 'package:food_delivery/base/custom_message.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_model.dart';
import 'package:food_delivery/pages/login/login_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../widgets/small_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _register(AuthController authController){
      String email = emailController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        customSnackBar("Type in your name", title: "Name Field");
      }else if(phone.isEmpty){
        customSnackBar("Enter a valid phone number", title: "Phone Number");
      }else if(email.isEmpty || !GetUtils.isEmail(email)){
        customSnackBar("Enter a valid email address", title: "Invalid Email");
      }else if(password.length<6 || password.isEmpty){
        customSnackBar("Enter at least 8 password characters", title: "Invalid Password");
      }else{
       SignUpModel signUpModel = SignUpModel(
            name: name,
            email: email,
            phone: phone,
            password: password);
        authController.registration(signUpModel).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
          }else{
            customSnackBar(status.message);
          }
        }

        );

      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?
        Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.07,),
            //Logo
            SizedBox(
              height: Dimensions.screenHeight*0.20,
              child: Center(
                child: CircleAvatar(
                  radius: Dimensions.radius20*4,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage(
                      "assets/image/logo1.jpg"
                  ),
                ),
              ),
            ),

            //Greetings
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height10, left: Dimensions.width20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.font18*2,
                    ),

                  ),
                  SmallText(
                    text: "Create your account",
                    size: Dimensions.font18-3,
                    color: Colors.black45,

                  )
                ],
              ),
            ),
            SizedBox(height: Dimensions.height10-5,),
            Expanded(child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [

                  //Name
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.1)
                          )
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.radius15)

                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        //hintText
                        hintText: "Name",

                        //prefixIcon
                        prefixIcon: Icon(Icons.person, color: AppColors.yellowColor,),

                        //focusedBorder
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.white
                            )

                        ),

                        //enabledBorder
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.white
                            )

                        ),

                        //border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                    ),
                  ),

                  //Email
                  SizedBox(height: Dimensions.height20,),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.1)
                          )
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.radius15)

                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        //hintText
                        hintText: "Email",

                        //prefixIcon
                        prefixIcon: Icon(Icons.email, color: AppColors.yellowColor,),

                        //focusedBorder
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.white
                            )

                        ),

                        //enabledBorder
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.white
                            )

                        ),

                        //border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                    ),
                  ),

                  //Phone
                  SizedBox(height: Dimensions.height20,),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.1)
                          )
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.radius15)

                    ),
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        //hintText
                        hintText: "Phone",

                        //prefixIcon
                        prefixIcon: Icon(Icons.phone, color: AppColors.yellowColor,),

                        //focusedBorder
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.white
                            )

                        ),

                        //enabledBorder
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.white
                            )

                        ),

                        //border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                    ),
                  ),

                  //Password
                  SizedBox(height: Dimensions.height20,),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.1)
                          )
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.radius15)

                    ),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        //hintText
                        hintText: "Password",

                        //prefixIcon
                        prefixIcon: Icon(Icons.password_rounded, color: AppColors.yellowColor,),

                        //focusedBorder
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.white
                            )

                        ),

                        //enabledBorder
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            borderSide: const BorderSide(
                                width: 1.0,
                                color: Colors.white
                            )

                        ),

                        //border
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                        ),
                      ),
                    ),
                  ),

                  //SignUp Button
                  SizedBox(height: Dimensions.height20+5,),
                  GestureDetector(
                    onTap: (){
                      _register(_authController);
                    },
                    child: Container(
                      width: Dimensions.screenWidth/2,
                      height: Dimensions.screenHeight/13,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                                color: Colors.grey.withOpacity(0.2)
                            )
                          ],
                          borderRadius: BorderRadius.circular(
                              Dimensions.radius30),
                          color: AppColors.mainColor
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sign Up",
                          color: Colors.white,
                          size: Dimensions.font18,

                        ),
                      ),
                    ),
                  ),

                  //Already have an account?
                  SizedBox(height: Dimensions.height10),
                  RichText(text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Already a customer? ",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.font18
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const LoginPage(), transition: Transition.fade),
                            text: "Login",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: Dimensions.font18
                            )
                        ),
                      ]

                  )
                  ),
                  SizedBox(height: Dimensions.height20+5),
                ],
              ),
            ))
          ],
        ):
        const CustomLoading();
      })
    );
  }
}
