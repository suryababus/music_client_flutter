import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "SomeThing went Wrong",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
