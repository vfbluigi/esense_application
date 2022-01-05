import 'package:flutter/material.dart';

class HeadacheImage extends StatelessWidget {
  const HeadacheImage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Image.asset(
        'assets/images/headache.png',
        scale: 1.2,
      ),
    );
  }
}