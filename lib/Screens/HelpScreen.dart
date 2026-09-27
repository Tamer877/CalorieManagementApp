import 'package:caloriemanagementapp/Widgets/CustomScaffold2.dart';
import 'package:caloriemanagementapp/Widgets/Drawer.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold2(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black54,
      ),
      drawer: MainDrawer(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color:Colors.black54,
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                      "HELLO AGAİN!",
                      style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                      )
                  ),
                ),
                Text(
                    "\nHere is some informations for you which  about how this application works,purposes of the sections and how you should calculate the calories and macros according to your purpose!",
                    style: TextStyle(
                        fontSize: 20,
                        wordSpacing: 4,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                ),
                Text(
                  "\n\nProfile Screen:",
                  style: TextStyle(
                      fontSize: 25,
                      wordSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple
                  ),
                ),
                Text(
                  "\nThis section includes your personel datas like your full name,height,weight,\nage,basal metabolism.Also you are able to update your personal datas and main purpose.",
                  style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 4,
                      color: Colors.white,
                      fontStyle: FontStyle.italic
                  ),
                ),
                Text(
                  "\n\nSearch Nutrition Screen:",
                  style: TextStyle(
                      fontSize: 25,
                      wordSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple
                  ),
                ),
                Text(
                  "\nIn this section you can search nutritions by typing their name and quantity(gram unit).Also you are able to save the nutritions you consume into history section.",
                  style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 4,
                      color: Colors.white,
                      fontStyle: FontStyle.italic
                  ),
                ),
                Text(
                  "\n\nHistory Screen:",
                  style: TextStyle(
                      fontSize: 25,
                      wordSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple
                  ),
                ),
                Text(
                  "\nIn this section you can see the nutritions you consumed in recent day and past days.Also you are able to see how your daily progress goes and see if you met necessary targets.",
                  style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 4,
                      color: Colors.white,
                      fontStyle: FontStyle.italic
                  ),
                ),
                Text(
                  "\n\nExplanation:",
                  style: TextStyle(
                      fontSize: 25,
                      wordSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple
                  ),
                ),
                Text(
                  "\nWe have calculated your basal metabolism.Basal metabolism is the calorie quantity that you must consume to stay healthy within a day with assuming you rest all day.To gain or lost weight care must be taken with basal metabolism while it also depends on your phsyical activity within a day.If you want to gain clean weight which means the weight you have gained must consist of muscle as most as possible and the rest is fat ,you have to consume at least 500 calories more than your basal metabolism,consume twice as much protein in grams for every kilogram of your weight,at most %20 of calories must consumed in a day healthy fat in calories,and rest of your calories you need to consume must consist of carbohydrates.To lost clean weight which means the weight you have lost must consist of mostly fat not muscle,you need to consume as much as your basal metabolism.You need to consume at most %10 of calories must consumed within a day healthy fat in calories and rest of your calories you need to consume must consist of carbohydrates.",
                  style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 4,
                      color: Colors.white,
                      fontStyle: FontStyle.italic
                  ),
                ),
                Text(
                  "\nExample:",
                  style: TextStyle(
                      fontSize: 22,
                      wordSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                  ),
                ),
                Text(
                  "\n1 gram protein = 4 calories\n1 gram carbohydrate = 4 calories\n1 gram fat = 9 calories\n\nFor instance basal metabolism of a person is 1700 calories and body weight of this person is 80kg.\n\nTo gain clean weight:\n\nThe calories that this person must consume is at least 1700+500 = 2200 kcal.\nThe protein that this person must consume is 80x2=160 g which makes 160x4 = 640 kcal.\nThe fat that this person must consume is at most 20x2200 / 100 = 440kcal and 440 / 9 = 48,8g\nThe carbohydrates that this person must take is (total calorie -protein(kcal)+fat(kcal)) 2200-(640+440) = 1120kcal and 1120 / 4 = 280g\n\nTo lost clean weight:\n\nThe calories that this person must consume is at least 1700kcal.\nThe protein that this person must consume is 80x2=160 gr which makes 160x4 = 640 kcal.\nThe fat that this person must consume is at most 10x1700 / 100 = 170kcal and 170 / 9 = 18,8g\nThe carbohydrates that this person must take is again(total calorie -protein(kcal)+fat(kcal)) 1700-(640+170) = 890kcal and 890 / 4 = 222,5g\n\nAs a result this is how you have to plan your calories and macros,I hope this app will be helpful to you:)",
                  style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 4,
                      color: Colors.white,
                      fontStyle: FontStyle.italic
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
