import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key,this.image});
  final Image ?image;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 135,
      width: 135,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: image
    );
  }
}

