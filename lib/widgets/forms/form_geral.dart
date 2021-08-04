import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/helpers.dart';

class FormGeral extends StatelessWidget {

  FormGeral({
    this.initialValue,
    this.labelText,
    this.hintText,
    this.enabled,
    this.autocorrect,
    this.autofocus,
    this.obscureText,
    this.maxLength,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.inputFormatters,
    this.validator,
    this.controller,
    this.maxLines,
    this.textCapitalization,
  });

  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final bool? enabled;
  final bool? autofocus;
  final bool? autocorrect;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: new ThemeData(
        hintColor: Colors.white,
        cursorColor: Colors.white,
        primarySwatch: Colors.grey,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        initialValue: initialValue,
        controller: controller,
        autofocus: autofocus??false,
        enabled:enabled??true,
        autocorrect: autocorrect??false,
        obscureText: obscureText??false,
        maxLines: maxLines,
        validator: validator,
        textCapitalization: textCapitalization??TextCapitalization.none,//TextCapitalization.sentences
        maxLength: maxLength,
        onChanged: onChanged,
        onSaved: onSaved,
        inputFormatters: inputFormatters,
        style: TextStyle(
          color: colorSmokyBlack,
          //fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          isDense: true,
          counterText: '',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: colorSmokyBlack,
            //fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: colorSmokyBlack,
            //fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );

  }
}