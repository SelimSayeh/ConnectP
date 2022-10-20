import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omnichannelplus/apiConstants.dart';
import 'package:omnichannelplus/core/app_colors.dart';
import 'package:omnichannelplus/src/models/Address.dart';
import 'package:omnichannelplus/src/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DIOClient {
  final Dio DIO = Dio();

  Future<User?> createUser({required User userInfo}) async {
    try {
      Response response = await DIO.post(
          ApiConstants.BASE_URL + ApiConstants.POST_USER,
          data: jsonEncode(userInfo));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "user created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.blueButton,
            textColor: AppColors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "user exists",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.blueButton,
          textColor: AppColors.white,
          fontSize: 16.0);
    }
  }

  Future<User?> createAddress({required Address address}) async {
    try {
      Response response = await DIO.post(
          ApiConstants.BASE_URL + ApiConstants.POST_ADDRESS,
          data: jsonEncode(address));

      print('address created: ${response.data}');
    } catch (e) {
      print('Error creating Address: $e');
    }
  }

  Future<User?> login({required User userInfo}) async {
    try {
      Response response = await DIO.post(
          ApiConstants.BASE_URL + ApiConstants.LOGIN,
          data: jsonEncode(userInfo));

      Fluttertoast.showToast(
          msg: "login success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.blueButton,
          textColor: AppColors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "login failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.blueButton,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
