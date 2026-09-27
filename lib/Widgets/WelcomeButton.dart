import "package:flutter/material.dart";


class Welcomebutton extends StatelessWidget {
  const Welcomebutton({super.key,this.buttonText,this.ontap,this.buttonColor,this.textColor});
  final String? buttonText;
  final Widget? ontap;
  final Color? buttonColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>ontap!
            )
        );
      },
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration:  BoxDecoration(
            color: buttonColor!,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
            )
        ),
        child: Text(
          buttonText!,
          textAlign: TextAlign.center,
          style:  TextStyle(
            color: textColor!,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
