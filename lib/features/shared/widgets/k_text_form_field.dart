import 'package:flutter/material.dart';

class KTextFormField extends StatelessWidget {
  const KTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.onChange,
    this.prefixIcon,
  });
  final TextEditingController textEditingController;
  final String hintText;
  final Function(String)? onChange;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onChanged: onChange,
      decoration: InputDecoration(prefixIcon: prefixIcon, hintText: hintText),
    );
  }
}
