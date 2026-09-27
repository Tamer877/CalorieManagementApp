import 'package:caloriemanagementapp/Screens/UserInformationScreen.dart';
import 'package:caloriemanagementapp/Widgets/CustomScaffold2.dart';
import 'package:caloriemanagementapp/Widgets/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  String fullName = "";
  String email = "";
  String age = "";
  String height = "";
  String weight = "";
  String gender = "";
  String purpose = "";
  double basalMetabolism = 0;
  bool isLoading = true;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    var user = await FirebaseFirestore.instance
        .collection("Users")
        .doc(_currentUser!.email)
        .get();
    setState(() {
      fullName = user['Full Name'];
      email = user['Email'];
      age = user['Age'].toString();
      height = user['Height'].toString();
      weight = user['Weight'].toString();
      gender = user['Gender'];
      purpose = user['Purpose'];
      basalMetabolism = user['Basal Metabolism'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black54,
      ),
      drawer: MainDrawer(),
      child: Container(
        color: Colors.black54,
        child: isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.green))
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    buildInfoRow("Full Name", fullName),
                    buildInfoRow("Email", email),
                    buildInfoRow("Age", "$age years"),
                    buildInfoRow("Height", "$height cm"),
                    buildInfoRow("Weight", "$weight kg"),
                    buildInfoRow("Gender", gender),
                    buildInfoRow("Purpose", purpose),
                    buildInfoRow("Basal Metabolism",
                        "${double.parse(basalMetabolism.toStringAsFixed(2))} kcal"),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (e) => Userinformationscreen(
                                name: fullName,
                                age: age,
                                height: height,
                                weight: weight,
                                gender: gender,
                                purpose: purpose,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(0, 60),
                        ),
                        child: const Text(
                          "Update Information",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              color: Colors.deepPurple,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
