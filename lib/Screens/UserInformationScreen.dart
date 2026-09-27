import 'package:caloriemanagementapp/Screens/HomeScreen.dart';
import 'package:caloriemanagementapp/Widgets/CustomScaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Userinformationscreen extends StatefulWidget {
  const Userinformationscreen({super.key,this.weight,this.height,this.age,this.name,this.gender,this.purpose});
  final String ?name;
  final String ?height;
  final String ?age;
  final String ?weight;
  final String ?gender;
  final String ? purpose;

  @override
  State<Userinformationscreen> createState() => _UserinformationscreenState();
}
List<String> genders = ['Male','Female'];
List<String> purposes = ['Gain Weight','Lost Weight'];
class _UserinformationscreenState extends State<Userinformationscreen> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  final _formInfoKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  late double basalMetabolism;

  bool checkForGender = true;
  bool checkForPurpose = true;
  String currentGender = genders[0];
  String currentPurpose = purposes[0];

  double _calculateBasalMetabolism (int age,double height,double weight,String gender ){
    late double basalMetabolism;
    if(gender == 'Male'){
      basalMetabolism = 88.362 +(13.397 * weight) +(4.799 * height) - (5.677 * age);
    }
    else if(gender == 'Female'){
      basalMetabolism = 447.593 + (9.247*weight) + (3.098*height) - (4.330 * age);
    }
    return basalMetabolism;
  }

  Future<String> _addUserInformations(String fullName,String email,int age,double height,double weight,String gender,double basalMetabolism,String purpose) async {
    try{
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(email).set({
        'Full Name' : fullName,
        'Email' : email,
        'Age' : age,
        'Height' : height,
        'Weight' : weight,
        'Gender' : gender,
        'Basal Metabolism' : basalMetabolism,
        'Purpose' : purpose
       }
      );
    }catch(e){
      return "An unknown error occured...";
    }
    return "";
  }

  @override
  void dispose(){
    _fullNameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.name != null && widget.age != null && widget.height != null && widget.weight!= null && widget.gender!= null && widget.purpose != null) {
      _fullNameController.text = widget.name!;
      _ageController.text = widget.age!;
      _heightController.text = widget.height!;
      _weightController.text = widget.weight!;
      if(checkForGender) {
        currentGender = widget.gender.toString();
        checkForGender = false;
      }
      if(checkForPurpose){
        currentPurpose = widget.purpose.toString();
        checkForPurpose = false;
      }
    }

    return CustomScaffold(
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
                  child:  Container(
                      padding: const EdgeInsets.fromLTRB(25,50,25,20),
                      decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )
                      ),
                      child : SingleChildScrollView(
                        child: Form(
                          key: _formInfoKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                textAlign: TextAlign.center,
                                "User Information",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                controller: _fullNameController,
                                validator: (value) {
                                  if(value == null || value.isEmpty){
                                    return "Please enter full name";
                                  }
                                  else if(!RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                                    return "Please enter a valid full name";
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration:  InputDecoration(
                                    label: const Text("Full Name",style: TextStyle(color: Colors.white),),
                                    hintText: "Enter full name",
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
                              const SizedBox(height: 20,),
                              TextFormField(
                                  controller: _ageController,
                                  validator: (value) {
                                    if(value == null || value.isEmpty){
                                      return "Please enter age";
                                    }
                                    else if(!RegExp(r'^\d+$').hasMatch(value)){
                                      return "Please enter a number";
                                    }
                                    else if(int.parse(value)<0){
                                      return "Age can't be less than zero";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration:  InputDecoration(
                                      label: const Text("Age",style: TextStyle(color: Colors.white),),
                                      hintText: "Enter age",
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
                              TextFormField(
                                controller: _heightController,
                                validator: (value) {
                                  if(value == null || value.isEmpty){
                                    return "Please enter your height";
                                  }
                                  else if(!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)){
                                    return "Please enter a number";
                                  }
                                  else if(double.parse(value)<0){
                                    return "Height can't be less than zero";
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration:  InputDecoration(
                                    label: const Text("Height(centimeters)",style: TextStyle(color: Colors.white),),
                                    hintText: "Enter your height",
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
                              const SizedBox(height: 20,),
                              TextFormField(
                                controller: _weightController,
                                validator: (value) {
                                  if(value == null || value.isEmpty){
                                    return "Please enter your weight";
                                  }
                                  else if(!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)){
                                    return "Please enter a number";
                                  }
                                  else if(double.parse(value)<0){
                                    return "Weight can't be less than zero";
                                  }
                                  return null;
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration:  InputDecoration(
                                    label: const Text("Weight(kilograms)",style: TextStyle(color: Colors.white),),
                                    hintText: "Enter your weight",
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
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Choose Gender:',style: TextStyle(fontSize: 17,color: Colors.white),),
                                  const SizedBox(width: 45,),
                                  const Text('Male',style: TextStyle(fontSize: 17,color: Colors.white),),
                                  Radio(
                                      value: genders[0],
                                      groupValue: currentGender,
                                      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                        if (states.contains(WidgetState.selected)) {
                                          return Colors.deepPurple;
                                        }
                                        return Colors.white;
                                      }),
                                      onChanged: (value){
                                        setState(() {
                                             currentGender = value.toString();
                                            }
                                          );
                                        }
                                      ),
                                  const Text('Female',style: TextStyle(fontSize: 17,color: Colors.white),),
                                  Radio(
                                      value: genders[1],
                                      groupValue: currentGender,
                                      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                        if (states.contains(WidgetState.selected)) {
                                          return Colors.deepPurple;
                                        }
                                        return Colors.white;
                                      }),
                                      onChanged: (value){
                                        setState(() {
                                             currentGender = value.toString();
                                            }
                                          );
                                        }
                                      ),
                                   ],
                               ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Choose your purpose:',style: TextStyle(fontSize: 17,color: Colors.white),),
                                    const SizedBox(width: 45,),
                                    const Text('Gain Weight',style: TextStyle(fontSize: 17,color: Colors.white),),
                                    Radio(
                                        value: purposes[0],
                                        groupValue: currentPurpose,
                                        fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                          if (states.contains(WidgetState.selected)) {
                                            return Colors.deepPurple;
                                          }
                                          return Colors.white;
                                        }),
                                        onChanged: (value){
                                          setState(() {
                                            currentPurpose = value.toString();
                                          }
                                          );
                                        }
                                    ),
                                    const Text('Lost Weight',style: TextStyle(fontSize: 17,color: Colors.white),),
                                    Radio(
                                        value: purposes[1],
                                        groupValue: currentPurpose,
                                        fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                          if (states.contains(WidgetState.selected)) {
                                            return Colors.deepPurple;
                                          }
                                          return Colors.white;
                                        }),
                                        onChanged: (value){
                                          setState(() {
                                            currentPurpose = value.toString();
                                          }
                                          );
                                        }
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40,),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:() async {
                                    if(_formInfoKey.currentState!.validate()){
                                      String fullName = _fullNameController.text.trim();
                                      int age = int.parse(_ageController.text.trim());
                                      double height = double.parse(_heightController.text.trim());
                                      double weight = double.parse(_weightController.text.trim());
                                      basalMetabolism = _calculateBasalMetabolism(age,height,weight,currentGender);

                                      await _addUserInformations(fullName, _currentUser!.email.toString(), age, height, weight, currentGender, basalMetabolism,currentPurpose).then((errorMessage){
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
                                                content: Text("Your datas has successfully saved"),
                                              )
                                          );
                                          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const HomeScreen()),
                                            (route) => false
                                          );
                                        }
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    minimumSize: const Size(0,60),
                                  ),
                                  child: const Text(
                                    "Done",
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
                        ),
                      )
                  )
              )
            ]
        )
    );
  }
}
