import 'package:caloriemanagementapp/Widgets/Drawer.dart';
import 'package:flutter/material.dart';

class CustomScaffold2 extends StatelessWidget {
  const CustomScaffold2({super.key,this.appBar,this.child,this.drawer});
  final AppBar? appBar;
  final Widget? child;
  final MainDrawer? drawer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar!,
      drawer: drawer!,
      extendBodyBehindAppBar: true,
      body: Stack(
          children: [
            Image.asset("Assets/Images/42324318-ba9f-4b04-9c13-e526f660b53d.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: child!,
            )
          ]
      ),
    );
  }
}
