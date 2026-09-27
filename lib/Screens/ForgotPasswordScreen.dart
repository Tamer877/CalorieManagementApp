import 'package:caloriemanagementapp/Widgets/CustomScaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  
  Future<String> _passwordReset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      return "";
    }on FirebaseAuthException catch (e){
      return e.message.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
          children: [
            const Expanded(
              flex: 9,
              child: SizedBox(
                height: 10,
              ),
            ),
            Expanded(
                flex: 7,
                child:  Container(
                    padding: const EdgeInsets.fromLTRB(25,50,25,20),
                    decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )
                    ),
                  child:  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Enter your email and we will send you a password reset link",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.green,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "Please enter Email";
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration:  InputDecoration(
                              label: const Text("Email",style: TextStyle(color: Colors.white),),
                              hintText: "Enter Email",
                              hintStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white
                                ),
                                borderRadius: BorderRadius.circular(10),
                              )
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              if(_formKey.currentState!.validate()) {
                                _passwordReset().then((errorMessage){
                                  if(errorMessage!=""){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(errorMessage),
                                        )
                                    );
                                  }
                                  else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Password reset link has successfully sent! Check your email"),
                                        )
                                      );
                                    }
                                  }
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(0,60),
                            ),
                            child: const Text(
                              "Reset Password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
            )
          ]
      ),
    );
  }
}
