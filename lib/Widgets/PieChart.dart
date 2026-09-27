import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({super.key,this.name,this.calories,this.proteins,this.carbohydrates,this.fat});
  final String? name;
  final double? calories;
  final double? proteins;
  final double? carbohydrates;
  final double? fat;


  @override
  Widget build(BuildContext context) {
    return Stack(
    alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name!.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
            Text("Calories : $calories kcal",style: TextStyle(color: Colors.yellowAccent,fontSize: 20,)),
            Text("Protein : $proteins g",style: TextStyle(color: Colors.white,fontSize: 20,)),
            Text("Fat : $fat g",style: TextStyle(color: Colors.deepPurple,fontSize: 20,)),
            Text("Carbohydrate : $carbohydrates g",style: TextStyle(color: Colors.green,fontSize: 20,)),
          ],
        ),
        PieChart(
            swapAnimationDuration: const Duration(milliseconds: 750),
            PieChartData(
                sectionsSpace: 10,
                sections: [
                  PieChartSectionData(
                    title: "",
                    value: double.parse((proteins!).toStringAsFixed(2)),
                    titleStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),
                    color: Colors.white
                  ),
                  PieChartSectionData(
                    title: "",
                    value:double.parse((fat!).toStringAsFixed(2)),
                    titleStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),
                    color: Colors.deepPurple
                  ),
                  PieChartSectionData(
                    title: "",
                    value: double.parse((carbohydrates!).toStringAsFixed(2)),
                    titleStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),
                    color: Colors.green
                  ),
                ]
            )
        )
      ],
    );
  }
}
