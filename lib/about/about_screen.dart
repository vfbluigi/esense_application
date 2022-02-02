import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({ Key? key }) : super(key: key);


  final String aboutText = 'HEADACHE by Louis Tiede\nDeveloped for Lecture "Mobile Computing and Internet of Things"\n12/2021';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HEADACHE'),
      ),
      body : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ABOUT',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 60,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              aboutText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w100,
              )
            ),
          ),
        ]          
      ),
    );
  }
}