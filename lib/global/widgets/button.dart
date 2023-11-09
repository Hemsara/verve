import 'package:flutter/material.dart';
import 'package:verve/global/widgets/loading_indicator.dart';

import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/text.dart';

class VerveButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  final bool outlined;
  final bool isLoading;

  const VerveButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.outlined = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          border:
              outlined ? Border.all(color: color ?? AppColors.primary) : null,
          borderRadius: BorderRadius.circular(AppDimensions.buttonRadiusMedium),
          color: outlined ? null : color ?? AppColors.primary,
        ),
        child: Center(
          child: isLoading
              ? const LoadingIndicator()
              : Text(
                  text,
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: textColor ?? Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
