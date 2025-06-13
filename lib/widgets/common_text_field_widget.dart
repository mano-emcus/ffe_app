import 'package:flutter/material.dart';

class CommonTextFieldWidget extends StatefulWidget {
  const CommonTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.isName = false,
  });
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  final bool isName;

  @override
  State<CommonTextFieldWidget> createState() => _CommonTextFieldWidgetState();
}

class _CommonTextFieldWidgetState extends State<CommonTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xFF707070).withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: widget.controller,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        obscureText: widget.isPassword,
        keyboardType:
            widget.isEmail
                ? TextInputType.emailAddress
                : widget.isPhone
                ? TextInputType.phone
                : TextInputType.text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1E1745),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black.withValues(alpha: 0.5),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
