import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omnichannelplus/DioClient.dart';
import 'package:omnichannelplus/SharedPrefManager.dart';
import 'package:omnichannelplus/apiConstants.dart';
import 'package:omnichannelplus/src/models/Address.dart';
import 'package:omnichannelplus/src/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_colors.dart';
import '../../core/app_images.dart';
import 'dart:async';

import '../models/User.dart';

//ADDRESS VIEW
class Register2 extends StatefulWidget {
  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final _formKey = GlobalKey<FormFieldState>();
  DIOClient dioClient = new DIOClient();
  late int verifAddress;
  User user = new User();
  final _totalDots = 2;
  double _currentPosition = 1.0;
  Address address = new Address();
  final cep = TextEditingController();
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    verifAddress = 0;
  }

  String getCurrentPositionPretty() {
    return (_currentPosition + 1.0).toStringAsPrecision(2);
  }

  Widget _body() {
    return Container(
      child: Form(
        key: _formKey,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 22.0, bottom: 22, right: 22, top: 10),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  verifAddress == 0
                      ? Flexible(
                          child: TextFormField(
                            controller: cep,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'CEP',
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter(),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                verifAddress == 1
                    ? Flexible(
                        flex: 10,
                        child: Text(
                          "Logradouro:" + address.logradouro,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  height: 15,
                ),
              ]),
              SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                verifAddress == 1
                    ? Flexible(
                        flex: 10,
                        child: Text(
                          "Complemento :" + address.complemento,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    : SizedBox(),
              ]),
              SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                verifAddress == 1
                    ? Flexible(
                        flex: 10,
                        child: Text(
                          "Localidade :" + address.localidade,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    : SizedBox(),
              ]),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verifAddress == 1
                      ? Flexible(
                          flex: 10,
                          child: Text(
                            "UF:" + address.uf,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verifAddress == 1
                      ? Flexible(
                          flex: 10,
                          child: Text(
                            "IBGE :" + address.ibge,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verifAddress == 1
                      ? Flexible(
                          flex: 10,
                          child: Text(
                            "GIA :" + address.gia,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verifAddress == 1
                      ? Flexible(
                          flex: 10,
                          child: Text(
                            "DDD:" + address.ddd,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verifAddress == 1
                      ? Flexible(
                          flex: 10,
                          child: Text(
                            "Siafi :" + address.siafi,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  verifAddress == 1 && address.complemento != null
                      ? Flexible(
                          flex: 10,
                          child: Text(
                            "Bairro:" + address.bairro,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 20,
              ),
              verifAddress == 1
                  ? SizedBox(
                      width: 340,
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
                          'Salvar Alterações',
                          style: TextStyle(
                            fontSize: 19,
                            color: AppColors.white,
                          ),
                        ),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          SharedPrefManager sharePrefManager =
                              new SharedPrefManager();
                          User userInfo =
                              await sharePrefManager.retrieveUser(user);
                          dioClient.createUser(userInfo: userInfo);
                          print(address.siafi);
                          address.toJson();
                          dioClient.createAddress(address: address);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      width: 340,
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
                            'Confirme o endereço',
                            style: TextStyle(
                              fontSize: 19,
                              color: AppColors.white,
                            ),
                          ),
                          onPressed: () async {
                            String cepInfo = validateCEP(cep.text);
                            ;
                            getCEP(cep: cepInfo, address: address);
                          }
                          //  Navigator.of(context).pop();
                          ),
                    ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 200),
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
                '2° Passo: preencha sua',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
              Text(
                'localização!',
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
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  String validateCEP(String s) {
    s = s.replaceAll(RegExp("-"), "");
    s = s.replaceAll(RegExp('\\.'), "");
    return s;
  }

  Future<Address?> getCEP(
      {required String cep, required Address address}) async {
    final prefs = await SharedPreferences.getInstance();
    final Dio DIO = Dio();
    try {
      Response response = await DIO.get((ApiConstants.CEP + cep + "/json/"));
      if (response.statusCode == 200) {
        var decoded = response.data;

        setState(() {
          verifAddress = 1;
          address.cep = address.logradouro = decoded['logradouro'];
          address.complemento = decoded['complemento'];
          address.bairro = decoded['bairro'];
          address.localidade = decoded['localidade'];
          address.uf = decoded['uf'];
          address.ibge = decoded['ibge'];
          address.gia = decoded['gia'];
          address.ddd = decoded['ddd'];
          address.siafi = decoded['siafi'];
        });

        Fluttertoast.showToast(
            msg: " success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.blueButton,
            textColor: AppColors.white,
            fontSize: 16.0);
      } else {
        verifAddress = 0;
        Fluttertoast.showToast(
            msg: " wrong CEP",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.blueButton,
            textColor: AppColors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      verifAddress = 0;
      prefs.setInt("verifValue", 0);
      Fluttertoast.showToast(
          msg: "Fail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.blueButton,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
