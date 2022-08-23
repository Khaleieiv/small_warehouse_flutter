import 'package:flutter/material.dart';

class AuthErrorDialog extends StatelessWidget {
  final String description;

  const AuthErrorDialog(this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(description),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}