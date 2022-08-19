import 'package:flutter/material.dart';
import 'package:small_warehouse/auth/presentation/widgets/custom_background.dart';
import 'package:small_warehouse/auth/presentation/widgets/header.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: CustomBackgroundForRegistrationPage(),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 25.0, top: 35.0),
                child: const Icon(Icons.arrow_back_ios, color: Colors.white,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: const <Widget>[
                  Header('Регистрация аккаунта'),
                  _GetInputs(),
                  _GetSignUp(),
                  _GetBottomRow(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _GetInputs extends StatelessWidget {
  const _GetInputs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const <Widget>[
          TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              labelText: 'Имя',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                labelText: 'E-mail',
                labelStyle: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'Пароль',
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class _GetSignUp extends StatelessWidget {
  const _GetSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Регистрация',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
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
}

class _GetBottomRow extends StatelessWidget {
  const _GetBottomRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Вход',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}