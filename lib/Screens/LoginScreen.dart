import "package:caloriemanagementapp/Screens/ForgotPasswordScreen.dart";
import "package:caloriemanagementapp/Screens/HomeScreen.dart";
import "package:caloriemanagementapp/Screens/SignUpScreen.dart";
import "package:caloriemanagementapp/Widgets/CustomScaffold.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:icons_plus/icons_plus.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formLoginKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (e) => const HomeScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  CustomScaffold(
        child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 10,
                ),
              ),
              Expanded(
                  flex: 7,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(25,50,25,20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )
                      ),
                      child : SingleChildScrollView(
                        child: Form(
                          key: _formLoginKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Welcome Back",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if(value == null || value.isEmpty){
                                    return "Please enter Email";
                                  }
                                  return null;
                                },
                                 decoration: InputDecoration(
                                    label: const Text("Email"),
                                    hintText: "Enter Email",
                                    hintStyle: const TextStyle(
                                      color: Colors.black26,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black12,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black12
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                obscuringCharacter: '*',
                                validator: (value) {
                                  if(value == null || value.isEmpty){
                                    return "Please enter Password";
                                  }
                                  return null;
                                },
                                decoration:  InputDecoration(
                                    label: const Text("Password"),
                                    hintText: "Enter Password",
                                    hintStyle: const TextStyle(
                                      color: Colors.black26,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black12,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black12
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (e) => const ForgetPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30,),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:(){
                                    if(_formLoginKey.currentState!.validate()){
                                      _loginUser();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    minimumSize: const Size(0,60),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child:Divider(
                                      thickness: 0.7,
                                      color: Colors.grey.withOpacity(1),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      "Login with",
                                      style: TextStyle(
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child:Divider(
                                      thickness: 0.7,
                                      color: Colors.grey.withOpacity(1),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Logo(Logos.google,size: 60,)
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (e) => const SignUpScreen()
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                  )
              )
            ]
        )
    );
  }
}
