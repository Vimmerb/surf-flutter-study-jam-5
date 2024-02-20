import 'package:flutter/material.dart';

class ErrorIcon extends StatelessWidget {
  const ErrorIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 80),
      child: Icon(
        Icons.error,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}
