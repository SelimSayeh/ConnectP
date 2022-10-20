import 'package:omnichannelplus/src/views/login_page.dart';
import '../../core/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/logo.png",
              height: 300,
              width: 300,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              primary: AppColors.blueButton,
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            child: Text(
              'Disconnect',
              style: TextStyle(
                fontSize: 19,
                color: AppColors.white,
              ),
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
