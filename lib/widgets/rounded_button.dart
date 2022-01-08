import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({ Key? key, required this.title, required this.onPressed, required this.icon }) : super(key: key);

  final String title;
  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue.shade300),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                    ),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 5 ),
                    child: Icon(icon),
                  ),
                  Text(
                    title,
                    ),
                ],
              ),
              onPressed: onPressed,      
            ),
          ),
        ],
      ),
    );
  }
}