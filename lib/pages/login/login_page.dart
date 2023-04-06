import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/sign_up/sign_up_page.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: Dimensions.screenHeight*0.05,),
          //Logo
          SizedBox(
            height: Dimensions.screenHeight*0.25,
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
                  "Hello",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.font18*4,
                  ),

                ),
                SmallText(
                  text: "Login to your account",
                  size: Dimensions.font18-3,
                  color: Colors.black45,

                )
              ],
            ),
          ),
          Expanded(child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
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
                            offset: const Offset(1, 10),
                            color: Colors.grey.withOpacity(0.1)
                        )
                      ],
                      borderRadius: BorderRadius.circular(Dimensions.radius30)

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
                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                          borderSide: const BorderSide(
                              width: 1.0,
                              color: Colors.white
                          )

                      ),

                      //enabledBorder
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                          borderSide: const BorderSide(
                              width: 1.0,
                              color: Colors.white
                          )

                      ),

                      //border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
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
                            offset: const Offset(1, 10),
                            color: Colors.grey.withOpacity(0.1)
                        )
                      ],
                      borderRadius: BorderRadius.circular(Dimensions.radius30)

                  ),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      //hintText
                      hintText: "Password",

                      //prefixIcon
                      prefixIcon: Icon(Icons.password_rounded, color: AppColors.yellowColor,),

                      //focusedBorder
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                          borderSide: const BorderSide(
                              width: 1.0,
                              color: Colors.white
                          )

                      ),

                      //enabledBorder
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius30),
                          borderSide: const BorderSide(
                              width: 1.0,
                              color: Colors.white
                          )

                      ),

                      //border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                      ),
                    ),
                  ),
                ),

                //Login
                SizedBox(height: Dimensions.height20+5,),
                Container(
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
                      text: "Login",
                      color: Colors.white,
                      size: Dimensions.font18,

                    ),
                  ),
                ),

                //Already have an account?
                SizedBox(height: Dimensions.height10),
                RichText(
                    text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font18
                    ),
                      children: [
                        TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(), transition: Transition.fade),
                    text: "Sign Up",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.font18
                    )),
                      ]
                ),
                ),
                SizedBox(height: Dimensions.height20+5),
              ],
            ),
          ))

        ],
      ),
    );
  }
}
