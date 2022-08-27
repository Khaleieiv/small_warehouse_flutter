import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_warehouse/auth/domain/entities/user.dart';
import 'package:small_warehouse/auth/presentation/state/auth_notifier.dart';
import 'package:small_warehouse/common/config/localization.dart';
import 'package:small_warehouse/common/config/string_constant.dart';
import 'package:small_warehouse/common/presentation/navigation/route_names.dart';
import 'package:small_warehouse/common/widgets/custom_snack_bar.dart';
import 'package:small_warehouse/common/widgets/text_field_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authNotifier = context.watch<AuthNotifier>();
    final userData = authNotifier.currentUser;

    return ListProfile(
      userData: userData,
    );
  }
}

class ListProfile extends StatefulWidget {
  final User? userData;

  const ListProfile({Key? key, required this.userData}) : super(key: key);

  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    final userData = widget.userData;
    nameController = TextEditingController(text: userData?.name);
    emailController = TextEditingController(text: userData?.email);
    passwordController = TextEditingController(text: userData?.password);
    phoneController = TextEditingController(text: userData?.phone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Locale nextLocale = Localization.getNextLocale(context)!;

    final authNotifier = context.watch<AuthNotifier>();
    final userData = authNotifier.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.myAppBarPage);
                    },
                    icon: const Icon(Icons.exit_to_app_outlined),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.language),
                    color: Colors.tealAccent,
                    onPressed: () {
                      EzLocalizationBuilder.of(context)!
                          .changeLocale(nextLocale);
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                context.getString('profile.label.profile'),
                style: const TextStyle(
                  fontSize: 27,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                controller: nameController,
                obscureText: false,
                label: context.getString('profile.label.name'),
                text: userData!.name,
                onChanged: (name) {},
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                controller: emailController,
                obscureText: false,
                label: context.getString('profile.label.email'),
                text: userData.email,
                onChanged: (email) {},
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                controller: passwordController,
                obscureText: true,
                label: context.getString('profile.label.password'),
                text: userData.password,
                onChanged: (about) {},
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldWidget(
                controller: phoneController,
                obscureText: false,
                label: context.getString('profile.label.phone'),
                text: userData.phone,
                onChanged: (about) {},
              ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.tealAccent,
                  padding: const EdgeInsets.all(20),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  final userId = userData.userId;
                  if (userId == null) {
                    final message = context
                        .getString('profile.message.error.not_update_profile');
                    CustomSnackBar.snackBarError(
                        StringConstants.title, message, context);
                    return;
                  }
                  await updateProfileUserDataOnPressed(
                    userId,
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                    phoneController.text,
                  );

                  if (!mounted) return;
                  final message = context
                      .getString('profile.message.successful.update_profile');
                  CustomSnackBar.snackBarOk(
                      StringConstants.title, message, context);

                  return;
                },
                child: Text(
                  context
                      .getString('profile.label.button_pressed_update_profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProfileUserDataOnPressed(
    int id,
    String name,
    String email,
    String password,
    String phone,
  ) async {
    final profileNotifier = context.read<AuthNotifier>();
    profileNotifier.updateProfile(id, name, email, password, phone);
  }
}
