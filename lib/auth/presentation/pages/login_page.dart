import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/auth/presentation/pages/registration_page.dart';
import 'package:small_warehouse/auth/presentation/state/auth_notifier.dart';
import 'package:small_warehouse/auth/presentation/widgets/custom_background.dart';
import 'package:small_warehouse/auth/presentation/widgets/header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get _enableSignInButton =>
      _loginController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    _loginController.addListener(_inputFieldValueChangeListener);
    _passwordController.addListener(_inputFieldValueChangeListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: CustomBackgroundForLoginPage(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: <Widget>[
              const Spacer(
                flex: 2,
              ),
              const Header('Welcome'),
              const Spacer(flex: 2,),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: _GetInputs(_loginController, _passwordController),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Вход',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.grey.shade800,
                    onPressed: _enableSignInButton ? signInButtonPressed : null,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const Spacer(),
              const _GetBottomRow(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _inputFieldValueChangeListener() {
    setState(() {});
  }

  void signInButtonPressed() {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
      authNotifier.signInWithEmail(
        _loginController.text,
        _passwordController.text,
      );
  }
}

class _GetInputs extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;

  const _GetInputs(this.loginController, this.passwordController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextField(
          controller: loginController,
          decoration: const InputDecoration(labelText: 'Логин'),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Пароль'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationPage()
                )
            );
          },
          child: const Text(
            'Регистрация',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
