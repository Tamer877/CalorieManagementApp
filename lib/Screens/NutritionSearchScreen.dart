import 'dart:convert';
import 'package:caloriemanagementapp/Models/Nutrition.dart';
import 'package:caloriemanagementapp/Widgets/CustomScaffold2.dart';
import 'package:caloriemanagementapp/Widgets/Drawer.dart';
import 'package:caloriemanagementapp/Widgets/PieChart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Nutritionsearchscreen extends StatefulWidget {
  const Nutritionsearchscreen({super.key});

  @override
  State<Nutritionsearchscreen> createState() => _NutritionSearchScreenState();
}

class _NutritionSearchScreenState extends State<Nutritionsearchscreen> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  Future<Nutrition?>? _nutritionFuture;
  final _formSearchKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _nameController = TextEditingController();

  Future<Nutrition?> _getNutrition() async{
    String name = _nameController.text.trim();
    String quantity = _quantityController.text.trim();
    String query = quantity+" "+name;
    String ?url ="https://api.calorieninjas.com/v1/nutrition?query=$query";

    var response = await http.get(Uri.parse(url),
        headers: {
          'x-api-key': 'inXmbhzdi1FA0Xs/Hu9kPw==fSPCHYBW3zDOh9Ed',
        }
    );
    if (response.statusCode == 200) {
      final dataString = response.body;
      final dataJson = jsonDecode(dataString);
      final nutritions = dataJson["items"];
      return Nutrition.fromJson(nutritions.first);
    } else {
       return null;
    }
  }

  Future<QuerySnapshot> _getExistingNutrition(String nutritionName,String? email,String currentDate) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot result = await firestore
        .collection('Users')
        .doc(email)
        .collection('History')
        .doc(currentDate)
        .collection('Nutritions').where('name' ,isEqualTo: nutritionName).get();
    return result;
  }

  Future<void> _setDailyHistory(String? email,String currentDate,Nutrition nutrition) async {
    _getExistingNutrition(nutrition.name, email, currentDate).then((result) async{
      if(result.docs.isEmpty){
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(email)
              .collection('History')
              .doc(currentDate)
              .collection('Nutritions')
              .doc(nutrition.name).set({
            'name' : nutrition.name,
            'calories' : double.parse((nutrition.calories).toStringAsFixed(2)),
            'protein_g' : double.parse((nutrition.protein).toStringAsFixed(2)),
            'carbohydrates_total_g' :double.parse((nutrition.carbohydrates).toStringAsFixed(2)),
            'fat_total_g' :double.parse((nutrition.fat).toStringAsFixed(2)),
          }
          );
      }
      else{
          Map<String,dynamic> existingDataMap = result.docs.first.data() as Map<String,dynamic>;
          Nutrition existingData = Nutrition.fromJson(existingDataMap);
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(email)
              .collection('History')
              .doc(currentDate)
              .collection('Nutritions')
              .doc(nutrition.name).set({
            'name' : nutrition.name,
            'calories' : double.parse((nutrition.calories + existingData.calories).toStringAsFixed(2)),
            'protein_g' : double.parse((nutrition.protein + existingData.protein).toStringAsFixed(2)),
            'carbohydrates_total_g' : double.parse((nutrition.carbohydrates + existingData.carbohydrates).toStringAsFixed(2)),
            'fat_total_g' : double.parse((nutrition.fat + existingData.fat).toStringAsFixed(2)),
          }
          );
      }
    }
    );
  }

  @override
  void dispose(){
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black54,
      ),
      drawer:  MainDrawer(),
      child:Container(
        color: Colors.black54,
        child: Column(
            children: [
              Expanded(
                  flex: 7,
                  child:  Container(
                      padding: const EdgeInsets.fromLTRB(25,50,25,20),
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child : SingleChildScrollView(
                        child: Form(
                          key: _formSearchKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Enter a nutrition name(like tomato) and a quantity(like 10g) if you enter an invalid quantity the default quantity is 100g.",style: TextStyle(fontSize: 13,color: Colors.white),),
                              const SizedBox(height: 25,),
                              TextFormField(
                                controller: _nameController,
                                validator: (value) {
                                  if(value == null || value.isEmpty){
                                    return "Please enter Nutrition name";
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration:  InputDecoration(
                                    label: const Text("Nutrition Name",style: TextStyle(color: Colors.white),),
                                    hintText: "Enter Nutrition Name",
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
                                    ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                  controller: _quantityController,
                                  validator: (value) {
                                    if(value == null || value.isEmpty){
                                      return "Please enter quantity";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration:  InputDecoration(
                                      label: const Text("Quantity",style: TextStyle(color: Colors.white),),
                                      hintText: "Enter Quantity",
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
                                  )
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 175,
                                    child: ElevatedButton(
                                      onPressed: (){
                                        if(_formSearchKey.currentState!.validate()){
                                          setState(() {
                                            _nutritionFuture = _getNutrition();
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        minimumSize: const Size(0,60),
                                      ),
                                      child: const Text(
                                        "Search",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 175,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        if(_formSearchKey.currentState!.validate()){
                                          try{
                                          _getNutrition().then((nutrition){
                                            if(nutrition!=null){
                                              DateTime currentDate = DateTime.now();
                                              String currentDateString = currentDate.toString().split(' ')[0];
                                              _setDailyHistory(_currentUser!.email, currentDateString,nutrition);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text("Nutrition has successfully added to daily history!"),
                                                  )
                                              );
                                            }
                                            else{
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text("There is no data to add!"),
                                                  )
                                              );
                                            }
                                          }
                                          );
                                        }catch(error){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("An error occured while adding nutrition to daily history!"),
                                              )
                                          );
                                        }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        minimumSize: const Size(0,60),
                                      ),
                                      child: const Text(
                                        textAlign: TextAlign.center,
                                        "Add To History",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                  )
              ),
               Expanded(
                flex: 8,
                child:  FutureBuilder<Nutrition?>(
                    future: _nutritionFuture,
                    builder: (context, snapshot) {
                       if (snapshot.hasError) {
                        return AlertDialog(content: Text(
                            "Error: ${snapshot.error}"),
                        );
                      }
                      else if (snapshot.hasData) {
                        Nutrition nutrition = snapshot.data!;
                        return  Container(
                            padding: const EdgeInsets.all(10),
                            child: MyPieChart(name: nutrition.name,calories: nutrition.calories,proteins: nutrition.protein,carbohydrates: nutrition.carbohydrates,fat: nutrition.fat,)
                        ) ;
                      }
                      else{
                        return const AlertDialog(content: Text("No data here!"),);
                      }
                    }
                ),
              ),
            ]
        ),
      )
    );
  }
}
