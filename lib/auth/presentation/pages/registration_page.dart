import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/auth/presentation/state/auth_notifier.dart';
import 'package:small_warehouse/auth/presentation/widgets/custom_background.dart';
import 'package:small_warehouse/auth/presentation/widgets/header.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _userDataFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phoneFormatter = PhoneInputFormatter();

  bool get _enableRegisterButton =>
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _phoneFormatter.isFilled;

  @override
  void initState() {
    _nameController.addListener(_inputFieldValueChangeListener);
    _emailController.addListener(_inputFieldValueChangeListener);
    _passwordController.addListener(_inputFieldValueChangeListener);
    _phoneController.addListener(_inputFieldValueChangeListener);
    super.initState();
  }

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
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  const Spacer(),
                  const Header('Регистрация аккаунта'),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: SingleChildScrollView(
                        child: _GetInputs(_nameController, _emailController,
                            _passwordController, _phoneController),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Регистрация',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.grey.shade800,
                        onPressed: _enableRegisterButton
                            ? _registerButtonPressed
                            : null,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const _GetBottomRow(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _inputFieldValueChangeListener() {
    setState(() {});
  }

  void _registerButtonPressed() {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    if (_userDataFormKey.currentState!.validate()) {
      authNotifier.registerAccount(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneFormatter.unmasked,
      );
    }
  }
}

class _GetInputs extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  const _GetInputs(this.nameController, this.emailController,
      this.passwordController, this.phoneController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            labelText: 'Имя',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.white)),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Пароль',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: phoneController,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: 'Phone',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
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
