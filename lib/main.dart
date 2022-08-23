import 'dart:io';

import 'package:flutter/material.dart';
import 'package:small_warehouse/auth/presentation/pages/login_page.dart';
import 'package:small_warehouse/auth/utils/my_http_overrides.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
