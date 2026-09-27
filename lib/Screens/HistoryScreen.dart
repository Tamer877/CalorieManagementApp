import 'package:caloriemanagementapp/Widgets/CustomScaffold2.dart';
import 'package:caloriemanagementapp/Widgets/Drawer.dart';
import 'package:caloriemanagementapp/Widgets/PieChart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key,});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  static DateTime date = DateTime.now();
  String dateString =  date.toString().split(' ')[0];

  double necessaryCalorie = 0;
  double necessaryProtein = 0;
  double necessaryFat = 0;
  double necessaryCarbohydrate = 0;

@override
  void initState () {
    currentStateOfUser();
    super.initState();
  }

  Future<void> currentStateOfUser() async {
    var user = await FirebaseFirestore.instance
        .collection("Users")
        .doc(_currentUser!.email)
        .get();
    String purpose = user['Purpose'];
    double basalMetabolism = user['Basal Metabolism'];
    double weight = user['Weight'];

    if(purpose=="Gain Weight"){
      necessaryCalorie = basalMetabolism + 500;
      necessaryProtein = weight*2;
      necessaryFat = (necessaryCalorie *20/100)/9;
      necessaryCarbohydrate = (necessaryCalorie - (necessaryProtein*4+necessaryFat*9))/4;
    }
    else if(purpose == "Lost Weight"){
      necessaryCalorie = basalMetabolism;
      necessaryProtein = weight*2;
      necessaryFat = (necessaryCalorie *10/100)/9;
      necessaryCarbohydrate = (necessaryCalorie - (necessaryProtein*4+necessaryFat*9))/4;
    }
  }

  Future<QuerySnapshot> _getDailyHistory(String date) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(_currentUser!.email)
        .collection('History')
        .doc(date)
        .collection('Nutritions')
        .get();
  }

  Future<void> deleteNutrition(String nutritionName,String? email,String currentDate) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore
          .collection('Users')
          .doc(email)
          .collection('History')
          .doc(currentDate)
          .collection('Nutritions')
          .doc(nutritionName).delete();

  }
  void _ShowDatePicker() {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2025),
          lastDate:DateTime(3000)
      ).then((value){
        if(value != null){
          setState(() {
            date = value;
            dateString = date.toString().split(' ')[0];
          });
        }
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
            Expanded(
              flex: 1,
              child: MaterialButton(
                  onPressed: _ShowDatePicker,
                  color: Colors.green,
                  child: const Text("Choose a date",style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              flex: 13,
              child: FutureBuilder(
                  future: _getDailyHistory(dateString),
                  builder: (context,snapshot){
                    if(snapshot.hasError){
                      return AlertDialog(content: Text("Error: ${snapshot.error}"),);
                    }
                    else if(snapshot.hasData) {
                      return ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic>? nutrition = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          return ListTile(
                            title: Container(
                                color: Colors.transparent,
                                width:400,
                                height: 400,
                                child: MyPieChart(name: nutrition['name'],calories: nutrition['calories'],proteins: nutrition['protein_g'],carbohydrates: nutrition['carbohydrates_total_g'],fat: nutrition['fat_total_g'],)
                            ),
                            subtitle: ElevatedButton(
                                onPressed: () async{
                                  try{
                                    await deleteNutrition(nutrition['name'],_currentUser!.email,dateString);
                                    setState(() {
                                      dateString = date.toString().split(' ')[0];
                                    });
                                  }catch(error){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("An error occured while deleting nutrition"),
                                        )
                                    );
                                  }

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green
                                ),
                               child: const Text("Remove",style: TextStyle(color: Colors.white,fontSize: 20),),
                            ),
                          );
                        },
                        separatorBuilder: (context,index) =>
                        const Divider(height: 30,color: Colors.white,),
                      );
                    }
                    else{
                      return const AlertDialog(content: Text("No data here!"),);
                    }
                  }
              ),
            ),
            Expanded(
                flex: 3,
                child: FutureBuilder(
                    future: _getDailyHistory(dateString),
                    builder: (context,snapshot){
                      if(snapshot.hasError){
                        return AlertDialog(content: Text("Error: ${snapshot.error}"),);
                      }
                      else if(snapshot.hasData){
                        double totalCalories = 0;
                        double totalFat = 0;
                        double totalProtein = 0;
                        double totalCarboHydrates = 0;

                        for(int index =0 ;index<snapshot.data!.docs.length ; index++){
                          Map<String, dynamic>? nutrition = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                          totalCalories += nutrition['calories'];
                          totalCarboHydrates += nutrition['carbohydrates_total_g'];
                          totalProtein += nutrition['protein_g'];
                          totalFat += nutrition['fat_total_g'];
                        }
                        totalCalories = double.parse((totalCalories).toStringAsFixed(2));
                        totalProtein = double.parse((totalProtein).toStringAsFixed(2));
                        totalFat = double.parse((totalFat).toStringAsFixed(2));
                        totalCarboHydrates = double.parse((totalCarboHydrates).toStringAsFixed(2));
                        return Column(
                          children: [
                            if(totalCalories < necessaryCalorie)
                              GestureDetector(
                                onTap:() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("You need to consume more calories to reach target ($necessaryCalorie kcal)"),
                                      )
                                  );
                                },
                                child: Text("Total Calories -> $totalCalories kcal",
                                  style: const TextStyle(color: Colors.red,
                                      fontSize: 19,
                                   ),),
                              )
                            else if(totalCalories >
                                necessaryCalorie + 1000)
                              GestureDetector(
                                onTap:() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("You have consumed too much calories than target ($necessaryCalorie kcal)"),
                                      )
                                  );
                                },
                                child: Text("Total Calories -> $totalCalories kcal",
                                  style: const TextStyle(color: Colors.red,
                                      fontSize: 19,
                               ),),
                              )
                            else if(totalCalories >= necessaryCalorie)
                                Text(
                                  "Total Calories -> $totalCalories kcal",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 19,
                                  ),)
                            ,
                            if(totalProtein < necessaryProtein)
                              GestureDetector(
                                onTap:() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("You need to consume more proteins to reach target ($necessaryProtein g)"),
                                      )
                                  );
                                },
                                child: Text("Total Protein -> $totalProtein g",
                                  style: const TextStyle(color: Colors.red,
                                      fontSize: 19,
                                    ),),
                              )
                            else if(totalProtein >= necessaryProtein)
                              Text("Total Protein -> $totalProtein g",
                                style: const TextStyle(color: Colors.green,
                                    fontSize: 19,
                                  ),)
                            ,
                            if(totalFat > necessaryFat)
                              GestureDetector(
                                onTap:() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("You have consumed much fat than target ($necessaryFat g)"),
                                      )
                                  );
                                },
                                child: Text("Total Fat -> $totalFat g",
                                  style: const TextStyle(color: Colors.red,
                                      fontSize: 19,
                                    ),),
                              )
                            else
                              Text("Total Fat -> $totalFat g",
                                style: const TextStyle(color: Colors.green,
                                    fontSize: 19,
                                ),)
                            ,
                            if(totalCarboHydrates > necessaryCarbohydrate)
                              GestureDetector(
                                onTap:() {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("You have consumed much carbohydrate than target ($necessaryCarbohydrate g)"),
                                      )
                                  );
                                },
                                child: Text(
                                  "Total Carbohydrates -> $totalCarboHydrates g",
                                  style: const TextStyle(color: Colors.red,
                                      fontSize: 19,
                                  ),),
                              )
                            else
                              Text(
                                "Total Carbohydrates -> $totalCarboHydrates g",
                                style: const TextStyle(color: Colors.green,
                                    fontSize: 19,
                                ),)
                          ],
                        );
                      }
                      else{
                        return const AlertDialog(content: Text("No data here!"),);
                      }
                    }
                )
            ),
          ],
        ),
      )
    );
  }
}

