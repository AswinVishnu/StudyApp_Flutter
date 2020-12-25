import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter/services.dart';

class RoundedMobileInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter> inputFormatters;
  const RoundedMobileInputField({
    Key key,
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.inputFormatters
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        maxLengthEnforced: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xff416d6d),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
