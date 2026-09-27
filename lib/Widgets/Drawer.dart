import 'package:caloriemanagementapp/Screens/HistoryScreen.dart';
import 'package:caloriemanagementapp/Screens/HelpScreen.dart';
import 'package:caloriemanagementapp/Screens/HomeScreen.dart';
import 'package:caloriemanagementapp/Screens/NutritionSearchScreen.dart';
import 'package:caloriemanagementapp/Screens/ProfileScreen.dart';
import 'package:caloriemanagementapp/Screens/WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
   MainDrawer({super.key});

  final User? _currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Container(
        color: Colors.black87,
        child: ListView(
          children: [
              DrawerHeader(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     const Padding(
                       padding: EdgeInsets.only(right: 150),
                       child: Text(
                         "MENU",
                        style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            letterSpacing: 9
                        ),
                                           ),
                     ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(right: 70),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "${_currentUser!.email}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.white,),
              title: const Text(
                "Home",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                )
              ),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            ),
            ListTile(
                leading: Icon(Icons.person,color: Colors.white,),
                title: const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                        color: Colors.white
                    )
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                }
            ),
            ListTile(
                leading: Icon(Icons.search,color: Colors.white,),
                title: const Text(
                    "Search Nutrition",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500, color: Colors.white
                    )
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Nutritionsearchscreen()));
                }
            ),
            ListTile(
                leading: Icon(Icons.help_outline,color: Colors.white,),
                title: const Text(
                    "Help",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                        color: Colors.white
                    )
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HelpScreen()));
                }
            ),
            ListTile(
                leading: Icon(Icons.history,color: Colors.white,),
                title: const Text(
                    "History",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                        color: Colors.white
                    )
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
                }
            ),
            Spacer(),
            ListTile(
                leading: Icon(Icons.logout,color: Colors.white,),
                title: const Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    )
                ),
                onTap: () async {
                  try{
                    FirebaseAuth.instance.signOut().then((value){
                      Navigator.pushAndRemoveUntil((context) , MaterialPageRoute(builder: (context) => WelcomeScreen()),
                              (route) => false
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Successfully signed out"),
                          )
                      );
                    }
                    );
                  }on FirebaseAuthException catch(_){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("An error occured while signing out"),
                        )
                    );
                  }
                },
            ),
          ],
        )
      ),
    );
  }
}
