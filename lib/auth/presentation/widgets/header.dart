import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String headerName;

  const Header(this.headerName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        headerName,
        style: const TextStyle(color: Colors.white, fontSize: 37),
      ),
    );
  }
}
