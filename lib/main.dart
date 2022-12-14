import 'dart:io';

import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:small_warehouse/auth/presentation/pages/login_page.dart';
import 'package:small_warehouse/auth/presentation/pages/registration_page.dart';
import 'package:small_warehouse/common/presentation/injector/widgets/injection_container.dart';
import 'package:small_warehouse/common/presentation/navigation/route_names.dart';
import 'package:small_warehouse/common/utils/my_http_overrides.dart';
import 'package:small_warehouse/common/widgets/my_bottom_app_bar.dart';
import 'package:small_warehouse/home/presentation/pages/home_page.dart';
import 'package:small_warehouse/profile/presentation/pages/profile_page.dart';
import 'package:small_warehouse/rent/presentation/pages/rent_page.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InjectionContainer(
      child:  EzLocalizationBuilder(
        delegate: const EzLocalizationDelegate(
          supportedLocales: [
            Locale('en'),
            Locale('ua'),
          ],
        ),
        builder: (context, localizationDelegate) => MaterialApp(
          initialRoute: RouteNames.loginPage,
          routes: {
            RouteNames.loginPage: (_) => const LoginPage(),
            RouteNames.registerPage: (_) => const RegistrationPage(),
            RouteNames.myAppBarPage: (_) => const MyBottomAppBar(),
            RouteNames.homePage: (_) => const HomePage(),
            RouteNames.rentPage: (_) => const RentPage(),
            RouteNames.profilePage: (_) => const ProfilePage(),
          },
          localizationsDelegates: localizationDelegate.localizationDelegates,
          supportedLocales: localizationDelegate.supportedLocales,
          localeResolutionCallback:
          localizationDelegate.localeResolutionCallback,
        ),
      ),
    );
  }
}