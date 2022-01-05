import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({ Key? key, required this.title, required this.onPressed }) : super(key: key);

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
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
              child: Text(
                title,
                ),
              onPressed: onPressed,      
            ),
          ),
        ],
      ),
    );
  }
}