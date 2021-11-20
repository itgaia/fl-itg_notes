import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final String title;
  // final void Function() onPressed;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.color,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(primary: color),
      child: Text(title),
    );
  }
}
