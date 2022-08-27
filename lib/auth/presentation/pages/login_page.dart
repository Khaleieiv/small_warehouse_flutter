import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/auth/presentation/pages/registration_page.dart';
import 'package:small_warehouse/auth/presentation/state/auth_notifier.dart';
import 'package:small_warehouse/auth/presentation/widgets/custom_background.dart';
import 'package:small_warehouse/auth/presentation/widgets/header.dart';
import 'package:small_warehouse/common/config/localization.dart';
import 'package:small_warehouse/common/presentation/navigation/route_names.dart';

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

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        key: navigatorKey,
        painter: CustomBackgroundForLoginPage(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            children: <Widget>[
              const Spacer(
                flex: 3,
              ),
              Header(
                context.getString('auth.welcome'),
              ),
              const Spacer(
                flex: 2,
              ),
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
                  Text(
                    context.getString('auth.login'),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
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

  Future<void> signInButtonPressed() async {
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    await authNotifier.signInWithEmail(
      _loginController.text,
      _passwordController.text,
    );
    if (!mounted) return;
    Navigator.pushNamed(context, RouteNames.myAppBarPage);
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
          decoration: InputDecoration(
            labelText: context.getString('auth.email'),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: context.getString('auth.password'),
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
    Locale nextLocale = Localization.getNextLocale(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationPage()));
          },
          child: Text(
            context.getString('auth.registration'),
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.language),
          color: Colors.tealAccent,
          onPressed: () {
            EzLocalizationBuilder.of(context)!.changeLocale(nextLocale);
          },
        ),
      ],
    );
  }
}
