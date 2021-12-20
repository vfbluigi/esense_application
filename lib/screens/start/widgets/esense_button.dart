import 'package:esense_application/screens/esense/esense_chart.dart';
import 'package:flutter/material.dart';

class ESenseButton extends StatelessWidget {
  const ESenseButton({ Key? key, required this.nextRoute, required this.title }) : super(key: key);

  final Widget nextRoute;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
            ),
        ),
      ),
      child: Text(
        title,
        ),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder:(context) => nextRoute),
        );
      },      
    );
  }
}