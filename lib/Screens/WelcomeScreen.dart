import 'package:caloriemanagementapp/Screens/LoginScreen.dart';
import 'package:caloriemanagementapp/Screens/SignUpScreen.dart';
import 'package:caloriemanagementapp/Widgets/CustomScaffold.dart';
import 'package:caloriemanagementapp/Widgets/WelcomeButton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScaffold(
      child: Column(
        children: [
          Flexible(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40
                ),
                child: Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Welcome!\n",
                                  style: TextStyle(
                                    fontSize: 45.0,
                                    fontWeight: FontWeight.bold,
                                  )
                              ),
                              TextSpan(
                                  text: "\nAre you ready to start journey of getting fit?",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  )
                              )
                            ]
                        )
                    )
                ),
              )
          ),
          const Flexible(
            flex: 2,
            child:Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Welcomebutton(
                        buttonText: "Login",
                        ontap: LoginScreen(),
                        buttonColor: Colors.transparent,
                        textColor: Colors.white,
                      )
                  ),
                  Expanded(
                      child: Welcomebutton(
                        buttonText: "Sign up",
                        ontap: SignUpScreen(),
                        buttonColor: Colors.white,
                        textColor: Colors.green,
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ) ,
    );
  }
}
