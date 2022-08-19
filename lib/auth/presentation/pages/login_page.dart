import 'package:flutter/material.dart';
import 'package:small_warehouse/auth/presentation/pages/registration_page.dart';
import 'package:small_warehouse/auth/presentation/widgets/custom_background.dart';
import 'package:small_warehouse/auth/presentation/widgets/header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: CustomBackgroundForLoginPage(),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  const Header('Welcome'),
                  _getInputs(),
                  _getSignIn(),
                  _getBottomRow(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

_getInputs() {
  return Expanded(
    flex: 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Логин'),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Пароль'),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

_getSignIn() {
  return Expanded(
    flex: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'Вход',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        CircleAvatar(
          backgroundColor: Colors.grey.shade800,
          radius: 40,
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}

_getBottomRow(context) {
  return Expanded(
    flex: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
          },
          child: const Text(
            'Регистрация',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
        ),
        const Text(
          'Забыли пароль',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline),
        )
      ],
    ),
  );
}

