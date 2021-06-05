import 'package:PROWORK/style/appColors.dart';
import 'package:PROWORK/utills/appConstraints.dart';
import 'package:flutter/material.dart';

class AppCustomInputField extends StatefulWidget {
  final double height;
  final String labelText;
  final String hintText;
  final Color labelColor;
  final String subStr;
  final bool obscure;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final bool hasValidation;
  final bool hasPrefix;
  final Widget prefixIcon;
  AppCustomInputField(
      {@required this.labelText,
      this.hintText = '',
      this.height = 70,
      this.labelColor = Colors.white,
      this.subStr,
      this.controller,
      this.obscure = false,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.hasValidation = false,
      this.hasPrefix = false,
      this.prefixIcon});
  @override
  _AppCustomInputFieldState createState() => _AppCustomInputFieldState();
}

class _AppCustomInputFieldState extends State<AppCustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0)),
      child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscure,
          keyboardType: widget.keyboardType,
          cursorHeight: 25.0,
          cursorColor: AppColors.blueColorGoogle,
          style: TextStyle(fontSize: 18),
          textAlignVertical: TextAlignVertical.center,
          maxLines: widget.maxLines,
          validator: (val) {
            return widget.hasValidation
                ? getValidatorMsg(widget.labelText, val)
                : null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              prefixIcon: widget.hasPrefix ? widget.prefixIcon : Container())),
    );
  }

  getValidatorMsg(String t, String value) {
    switch (t) {
      case AppConstants.taskTitleLabel:
        return value.length < 15
            ? AppConstants.taskTitleValidationMessage
            : null;
        break;
      case AppConstants.taskDesLabel:
        return value.length < 40 ? AppConstants.taskDesValidationMessage : null;
        break;
      case AppConstants.taskBudgetLabel:
        return value.length < 1
            ? AppConstants.taskBudgetValidationMessage
            : null;
        break;
    }
    return null;
  }
}
