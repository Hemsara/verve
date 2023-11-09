import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/text.dart';

enum TextFieldType {
  text,
  address,
  password,
  email,
  number,
}

class VerveField extends StatefulWidget {
  final TextEditingController? controller; // Controller for the text field
  final String label; // Label for the text field
  final String hint; // Hint text for the text field
  final TextFieldType textFieldType; // Type of text field
  final IconData icon;

  const VerveField({
    Key? key,
    this.controller,
    required this.label,
    this.hint = "",
    this.textFieldType = TextFieldType.text,
    required this.icon,
  }) : super(key: key);

  @override
  State<VerveField> createState() => _VerveFieldState();
}

class _VerveFieldState extends State<VerveField> {
  late bool obscured; // to control text obscuration (for password)

  @override
  void initState() {
    if (widget.textFieldType == TextFieldType.password) {
      obscured = true;
    }
    super.initState();
  }

  // Determine the keyboard type based on the text field type
  TextInputType getKeyboardType() {
    switch (widget.textFieldType) {
      case TextFieldType.address:
        return TextInputType.streetAddress;
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.baseSize * 2),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          // Validate the text field input
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        keyboardType: getKeyboardType(),

        obscureText:
            widget.textFieldType == TextFieldType.password ? obscured : false,
        style: AppTextStyles.bodyRegular, // Text style for the input

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(AppDimensions.baseSize * 3),
          suffixIcon: widget.textFieldType == TextFieldType.password
              ? GestureDetector(
                  onTap: () {
                    // Toggle text obscuration
                    setState(() {
                      obscured = !obscured;
                    });
                  },
                  child: Icon(
                    obscured ? Iconsax.eye : Iconsax.eye_slash,
                    size: 16,
                  ),
                )
              : null,
          labelText: widget.label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.primary,
            size: 20,
          ),
          labelStyle:
              AppTextStyles.bodyRegular.copyWith(color: AppColors.gray100),
          hintStyle:
              AppTextStyles.bodyExtraSmall.copyWith(color: AppColors.gray200),
          hintText: widget.hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray200),
            borderRadius:
                BorderRadius.circular(AppDimensions.buttonRadiusMedium),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray200),
            borderRadius:
                BorderRadius.circular(AppDimensions.buttonRadiusMedium),
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.buttonRadiusMedium),
          ),
        ),
      ),
    );
  }
}
