import 'package:flutter/material.dart';

class RowForTextAndDropDownList extends StatelessWidget {
  final String label;
  final Widget dropdownItem;

  const RowForTextAndDropDownList(
      this.label,
      this.dropdownItem, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 3,
          child: dropdownItem,
        ),
        const Spacer(),
      ],
    );
  }
}