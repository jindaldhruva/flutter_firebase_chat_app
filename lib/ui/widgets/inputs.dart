import 'package:get/get.dart';

import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key key,
    this.tec,
    this.decoration,
    this.obscure,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
    this.mandatory = false,
    @required this.label,
  }) : super(key: key);
  final TextEditingController tec;
  final InputDecoration decoration;
  final bool obscure;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputAction textInputAction;
  final FormFieldValidator<String> validator;
  final bool mandatory;
  final String label;
  DefaultTextField.password(
    bool isConPaas, {
    this.tec,
    @required this.obscure,
    @required VoidCallback showPass,
    @required VoidCallback hidePass,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.validator,
    @required this.mandatory,
  })  : label = isConPaas ? 'Confirm Password' : 'Password',
        decoration = InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
          ),
          suffixIcon: AnimatedCrossFade(
            firstChild: IconButton(
              icon: Icon(Icons.visibility),
              onPressed: showPass,
            ),
            secondChild: IconButton(
              icon: Icon(Icons.visibility_off),
              onPressed: hidePass,
            ),
            crossFadeState:
                obscure ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: 200.milliseconds,
          ),
        );
  String get _labelText => mandatory
      ? label.substring(0, 1).toUpperCase() + label.substring(1) + '*'
      : label.substring(0, 1).toUpperCase() + label.substring(1);

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        size: 40,
      ),
      child: TextFormField(
        validator: (value) {
          if (mandatory) {
            if (value == '') return '$label is required';

            return validator?.call(value);
          } else {
            return validator?.call(value);
          }
        },
        focusNode: focusNode,
        controller: tec,
        textInputAction: textInputAction ?? TextInputAction.done,
        obscureText: obscure ?? false,
        onFieldSubmitted: onFieldSubmitted,
        obscuringCharacter: '*',
        decoration: decoration == null
            ? InputDecoration(
                border: UnderlineInputBorder(),
                labelText: _labelText,
              )
            : decoration.copyWith(
                border: UnderlineInputBorder(),
                labelText: _labelText,
              ),
      ),
    );
  }
}
