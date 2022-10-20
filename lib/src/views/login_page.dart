import 'package:omnichannelplus/DioClient.dart';
import 'package:omnichannelplus/core/extensions.dart';
import 'package:omnichannelplus/src/models/User.dart';
import 'package:omnichannelplus/src/views/register_page.dart';
import '../../core/app_colors.dart';
import '../../core/app_images.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DIOClient dioClient = new DIOClient();
  var _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  Widget _body() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(22.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
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
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Senha', border: OutlineInputBorder()),
                        validator: (input) =>
                            input!.isNotEmpty ? null : "insira sua senha"),
                    SizedBox(
                      height: 31,
                    ),
                    SizedBox(
                      width: 330,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.blueButton,
                          shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            User userInfo = new User(
                                password: password.text, email: email.text);
                            userInfo.toJson();
                            dioClient.login(userInfo: userInfo);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    GestureDetector(
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                color: AppColors.brownText3,
                                fontSize: 16,
                              ),
                              text: 'Já tem uma conta?',
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' Cadastre-se',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.redCadastro,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register1(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 58,
                    ),
                  ],
                ),
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
            padding: EdgeInsets.only(top: 150),
            child: _body(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Image(
                image: AssetImage(AppImages.upper),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              Image(
                image: AssetImage(AppImages.logo),
                width: 400,
                height: 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
