import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> initSharedPrefs() async {
  return SharedPreferences.getInstance();
}

Future<bool> isAuth() async {
  final prefs = await initSharedPrefs();
  return prefs.getString('token') != null;
}

Future getToken() async {
  final prefs = await initSharedPrefs();
  return prefs.getString('token');
}

Future getId() async {
  final prefs = await initSharedPrefs();
  return prefs.getString('id');
}

Future clearPrefs() async {
  final prefs = await initSharedPrefs();
  prefs.clear();
}

setSnackBar(String text, String label, Function() onPressed) {
  return SnackBar(
    content: Text(text),
    action: SnackBarAction(
      label: label,
      onPressed: onPressed,
    ),
  );
}
