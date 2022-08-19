import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String headerName;
  const Header(this.headerName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Text(headerName,
          style: const TextStyle(color: Colors.white, fontSize: 37),
        ),
      ),
    );
  }
}