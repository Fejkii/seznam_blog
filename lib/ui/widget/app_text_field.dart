import 'package:flutter/material.dart';
import 'package:seznam_blog/app/app_functions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum InputType {
  email,
  title,
}

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final InputType? inputType; // if inputType is entered, the input value is validated by the inputType
  final bool? isRequired;
  final Function(String)? onChange;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.inputType,
    this.isRequired = false,
    this.onChange,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      validator: (value) {
        if (widget.isRequired == true) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.requiredField;
          }
        }
        switch (widget.inputType) {
          case InputType.email:
            if (value != null && value.isNotEmpty && !isEmailValid(value)) {
              return AppLocalizations.of(context)!.validEmail;
            }
            break;
          case InputType.title:
            if (value != null && value.isNotEmpty && !isTitleValid(value)) {
              return AppLocalizations.of(context)!.validTitle;
            }
            break;
          default:
            return null;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChange,
    );
  }
}
