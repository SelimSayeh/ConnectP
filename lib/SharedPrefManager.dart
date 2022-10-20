import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omnichannelplus/src/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("password", user.password);
    prefs.setString("channelId", user.channelId);
    prefs.setBool("channelStatus", user.channelStatus);
  }

  Future<User> retrieveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    user.name = prefs.getString("name")!;
    user.email = prefs.getString("email")!;
    user.password = prefs.getString("password")!;
    user.channelId = prefs.getString("channelId")!;
    user.channelStatus = prefs.getBool("channelStatus")!;
    return user;
  }
}
