import 'dart:convert';
import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:omnichannelplus/DioClient.dart';
import 'package:omnichannelplus/SharedPrefManager.dart';
import 'package:omnichannelplus/core/extensions.dart';
import 'package:omnichannelplus/src/models/User.dart';
import 'package:omnichannelplus/src/views/register2_page.dart';

import '../../core/app_colors.dart';
import '../../core/app_images.dart';

//REGISTER1 VIEW
class Register1 extends StatefulWidget {
  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  final _totalDots = 2;
  double _currentPosition = 0.0;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();
  final email = TextEditingController();
  final password = TextEditingController();
  SharedPrefManager sharedPrefManager = new SharedPrefManager();

  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1.0;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  String getCurrentPositionPretty() {
    return (_currentPosition + 1.0).toStringAsPrecision(2);
  }

  Widget _body() {
    return Container(
      child: Form(
        key: _formkey,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 67,
                  ),
                  TextFormField(
                    controller: email,
                    style: TextStyle(
                      color: AppColors.blackCupons,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'E-mail', border: OutlineInputBorder()),
                    validator: (input) => input!.isValidEmail()
                        ? null
                        : "Entre com um email válido",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: password,
                    key: passKey,
                    style: TextStyle(
                      color: AppColors.blackCupons,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Senha', border: OutlineInputBorder()),
                    validator: (password) {
                      var result = password!.length < 5
                          ? "A senha deve ter pelo menos 5 caracteres"
                          : null;
                      return result;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: AppColors.blackCupons,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Confirmar Senha',
                        border: OutlineInputBorder()),
                    validator: (confirmation) {
                      var password = passKey.currentState!.value;
                      return confirmation == password
                          ? null
                          : "Confirmar senha deve corresponder à senha";
                    },
                  ),
                  SizedBox(
                    height: 31,
                  ),
                  SizedBox(
                    width: 330,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        primary: AppColors.blueButton,
                        shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      child: Text(
                        'Próximo passo',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (!_formkey.currentState!.validate()) {
                          return;
                        } else if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          User user = new User(
                              password: password.text, email: email.text);
                          sharedPrefManager.saveUserData(user);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Register2()),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: _body(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Image.asset(
                AppImages.upper,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              Image(
                image: AssetImage(AppImages.logo),
                width: 147,
                height: 100,
              ),
              Text(
                '1° Passo: cadastre seu',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
              Text(
                'email principal!',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
              _buildRow([
                Center(
                  child: DotsIndicator(
                    dotsCount: _totalDots,
                    position: _currentPosition,
                    decorator: DotsDecorator(
                      size: Size(11, 11),
                      activeSize: Size.square(11),
                      spacing:
                          EdgeInsets.symmetric(horizontal: 3, vertical: 25),
                      color: Colors.transparent,
                      activeColor: AppColors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: AppColors.white,
                          width: 0.7,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
