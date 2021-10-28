import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociomusic/screen/home_screen/room_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                padding: EdgeInsets.all(10),
                child: Image.asset('assets/images/app_icon.png'),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'SocioMusic',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
