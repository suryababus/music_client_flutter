import 'package:flutter/material.dart';

class InstallSpotifyScreen extends StatelessWidget {
  const InstallSpotifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please install spotify to proceed",
                style: TextStyle(color: Colors.white),
              ),
              Divider(),
              TextButton(
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Color(0Xff0177fa),
                  child: Text(
                    'INSTALL SPOTIFY',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
