import 'dart:io';

import 'package:flutter/material.dart';
import 'package:small_warehouse/auth/presentation/pages/login_page.dart';
import 'package:small_warehouse/common/presentation/injector/widgets/injection_container.dart';
import 'package:small_warehouse/common/utils/my_http_overrides.dart';
import 'package:small_warehouse/common/widgets/my_bottom_app_bar.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MaterialApp(home: MyBottomAppBar()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InjectionContainer(
      child:  MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
