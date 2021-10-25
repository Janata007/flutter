import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends TextFormField {
  MyTextFormField({required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    required List<TextInputFormatter> inputFormatter,
    bool autofocus = false,
    bool obscureText = false,
    required String label})
      : super(
      controller: controller,
      onSaved: onSaved,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter,
      autofocus: autofocus,
      obscureText: obscureText,
      validator: validator,
      decoration: MyInputDecoration(hintText: label));
}

class MyInputDecoration extends InputDecoration {
  MyInputDecoration({required String hintText})
      : super(
      hintText: hintText,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0))
  );
}