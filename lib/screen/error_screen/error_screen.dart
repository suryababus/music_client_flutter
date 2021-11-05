import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({Key? key}) : super(key: key);
  final String errorTitle = Get.arguments?['errorTitle'] ?? "Error!";
  final String errorMessage =
      Get.arguments?['errorMessage'] ?? "SomeThing went Wrong";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              errorTitle,
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
              ),
            ),
            Divider(),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Get.offAllNamed('/splash');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.replay_rounded,
                    color: Colors.blue.withOpacity(0.8),
                  ),
                  Text(
                    'reload',
                    style: TextStyle(
                      color: Colors.blue.withOpacity(0.8),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
