import 'package:caloriemanagementapp/Screens/HistoryScreen.dart';
import 'package:caloriemanagementapp/Screens/HelpScreen.dart';
import 'package:caloriemanagementapp/Screens/NutritionSearchScreen.dart';
import 'package:caloriemanagementapp/Screens/ProfileScreen.dart';
import 'package:caloriemanagementapp/Widgets/CustomContainer.dart';
import 'package:caloriemanagementapp/Widgets/CustomScaffold2.dart';
import 'package:caloriemanagementapp/Widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  double necessaryCalorie = 0;
  double necessaryProtein = 0;
  double necessaryFat = 0;
  double necessaryCarbohydrate = 0;
  String purpose = "";

  @override
  void initState(){
    currentStateOfUser();
    super.initState();
  }

  Future<void> currentStateOfUser() async {
    var user = await FirebaseFirestore.instance
        .collection("Users")
        .doc(_currentUser!.email)
        .get();
    String purposeFromDb = user['Purpose'];
    double basalMetabolism = user['Basal Metabolism'];
    double weight = user['Weight'];

    if(purposeFromDb=="Gain Weight"){
      necessaryCalorie = basalMetabolism + 500;
      necessaryProtein = weight*2;
      necessaryFat = (necessaryCalorie *20/100)/9;
      necessaryCarbohydrate = (necessaryCalorie - (necessaryProtein*4+necessaryFat*9))/4;
    }
    else if(purposeFromDb == "Lost Weight"){
      necessaryCalorie = basalMetabolism;
      necessaryProtein = weight*2;
      necessaryFat = (necessaryCalorie *10/100)/9;
      necessaryCarbohydrate = (necessaryCalorie - (necessaryProtein*4+necessaryFat*9))/4;
    }
    setState(() {
      purpose = purposeFromDb;
      necessaryCalorie = double.parse((necessaryCalorie).toStringAsFixed(2));
      necessaryProtein = double.parse((necessaryProtein).toStringAsFixed(2));
      necessaryFat = double.parse((necessaryFat).toStringAsFixed(2));
      necessaryCarbohydrate = double.parse((necessaryCarbohydrate).toStringAsFixed(2));
    });
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black54,
      ),
      drawer:  MainDrawer(),
      child: Container(
        color: Colors.black54,
        child: Column(
           children: [
             const SizedBox(height: 10,),
             const Text("Patience + Determination = Success",
               style: TextStyle(color: Colors.white,fontSize: 25),
             ),
             const SizedBox(height: 25,),
             Text("Main Purpose -> $purpose",
               style: const TextStyle(color: Colors.green,
                   fontSize: 30,
                   ),),
             const SizedBox(height: 35,),
             Text("Target Calorie -> $necessaryCalorie kcal",
               style: const TextStyle(color: Colors.deepPurple,
                   fontSize: 25,
                   ),),
             Text("Target Protein -> $necessaryProtein g",
               style: const TextStyle(color: Colors.deepPurple,
                   fontSize: 25,
                   ),),
             Text("Target Fat -> $necessaryFat g",
               style: const TextStyle(color: Colors.deepPurple,
                   fontSize: 25,
                   ),),
             Text("Target Carbohydrate -> $necessaryCarbohydrate g",
               style: const TextStyle(color: Colors.deepPurple,
                   fontSize: 25,
                   ),),
             const SizedBox(height: 40,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const SizedBox(),
                 GestureDetector(
                   onTap: () {
                     Navigator.pushAndRemoveUntil((context), MaterialPageRoute(
                         builder: (e) => const ProfileScreen()), (route) => false
                     );
                   },
                   child: CustomContainer(
                     image:Image.asset("Assets/Icons/profile.png",),
                   ),
                 ),
                 GestureDetector(
                   onTap: () {
                     Navigator.pushAndRemoveUntil((context), MaterialPageRoute(
                         builder: (e) => const Nutritionsearchscreen()), (route) => false
                     );
                   },
                   child: CustomContainer(
                     image:Image.asset("Assets/Icons/circle.png",),
                   ),
                 ),
                 const SizedBox(),
               ],
             ),
             const Row(
               children: [
                 SizedBox(width: 80,),
                 Text("Profile",style: TextStyle(color: Colors.white ,fontSize: 25,fontWeight: FontWeight.bold),),
                 SizedBox(width: 70,),
                 Text("Search Nutrition",style: TextStyle(color: Colors.white ,fontSize: 25,fontWeight: FontWeight.bold),),
               ],
             ),
             const SizedBox(height: 50,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const SizedBox(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(
                        builder: (e) => const HelpScreen()), (route) => false
                    );
                  },
                  child: CustomContainer(
                    image:Image.asset("Assets/Icons/information.png"),
                  ),
                ),
                 GestureDetector(
                   onTap: () {
                     Navigator.pushAndRemoveUntil((context), MaterialPageRoute(
                         builder: (e) => const HistoryScreen()), (route) => false
                     );
                   },
                   child: CustomContainer(
                     image:Image.asset("Assets/Icons/documents.png"),
                   ),
                 ),
                 const SizedBox(),
               ],
             ),
             const Row(
               children: [
                 SizedBox(width: 90,),
                 Text("Help",style: TextStyle(color: Colors.white ,fontSize: 25,fontWeight: FontWeight.bold),),
                 SizedBox(width: 125,),
                 Text("History",style: TextStyle(color: Colors.white ,fontSize: 25,fontWeight: FontWeight.bold),),
               ],
             ),
           ],
        ),
      ),
    );
  }
}
