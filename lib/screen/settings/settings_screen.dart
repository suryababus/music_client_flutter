import 'package:flutter/material.dart';

var textStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.w900);

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      ),
      body: Center(
          child: Column(
        children: [
          ThemeSettingTile(),
          Divider(
            height: 3,
          ),
          FaceBookSettingTile(),
          Divider(
            height: 3,
          ),
          PrivacySettingTile(),
          Divider(
            height: 3,
          ),
          ContactSupportTile(),
          Divider(
            height: 3,
          ),
          AboutUsTile(),
          Divider(
            height: 3,
          ),
          SignOutTile()
        ],
      )),
    );
  }
}

class ThemeSettingTile extends StatelessWidget {
  const ThemeSettingTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(33, 33, 43, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: Icon(
          Icons.window_rounded,
          size: 30,
          color: Color(0Xff4084C2),
        ),
        minLeadingWidth: 0,
        tileColor: Colors.white.withOpacity(0.05),
        title: Text(
          "Theme",
          style: textStyle,
        ),
        trailing: Icon(
          Icons.arrow_right_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class FaceBookSettingTile extends StatelessWidget {
  const FaceBookSettingTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(33, 33, 43, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: Icon(
          Icons.facebook_outlined,
          size: 30,
          color: Color(0Xff4084C2),
        ),
        minLeadingWidth: 0,
        tileColor: Colors.white.withOpacity(0.05),
        title: Text(
          "Connect To Facebook",
          style: textStyle,
        ),
      ),
    );
  }
}

class PrivacySettingTile extends StatelessWidget {
  const PrivacySettingTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(33, 33, 43, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: Icon(
          Icons.fingerprint_outlined,
          size: 30,
          color: Color(0Xff4084C2),
        ),
        minLeadingWidth: 0,
        tileColor: Colors.white.withOpacity(0.05),
        title: Text(
          "Privacy Settings",
          style: textStyle,
        ),
      ),
    );
  }
}

class ContactSupportTile extends StatelessWidget {
  const ContactSupportTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(33, 33, 43, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: Icon(
          Icons.support_agent_outlined,
          size: 30,
          color: Color(0Xff4084C2),
        ),
        minLeadingWidth: 0,
        tileColor: Colors.white.withOpacity(0.05),
        title: Text(
          "Contact Support",
          style: textStyle,
        ),
      ),
    );
  }
}

class AboutUsTile extends StatelessWidget {
  const AboutUsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(33, 33, 43, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        leading: Icon(
          Icons.info_outline,
          size: 30,
          color: Color(0Xff4084C2),
        ),
        minLeadingWidth: 0,
        tileColor: Colors.white.withOpacity(0.05),
        title: Text(
          "About Us",
          style: textStyle,
        ),
      ),
    );
  }
}

class SignOutTile extends StatelessWidget {
  const SignOutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(33, 33, 43, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        minLeadingWidth: 0,
        tileColor: Colors.white.withOpacity(0.05),
        title: Center(
          child: Text(
            "Sign out",
            style:
                TextStyle(color: Colors.red[400], fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
