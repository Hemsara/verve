import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:verve/global/widgets/loading_indicator.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/text.dart';

enum ButtonSize { small, large }

class VerveButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final ButtonSize buttonSize;

  final bool outlined;
  final bool isLoading;
  final String? iconAsset;

  const VerveButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.buttonSize = ButtonSize.large,
    this.outlined = false,
    this.isLoading = false,
    this.iconAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLoading) {
          return;
        }
        onTap();
      },
      child: Container(
        padding: buttonSize == ButtonSize.small
            ? const EdgeInsets.symmetric(vertical: 13)
            : null,
        height: buttonSize == ButtonSize.small ? null : 65,
        decoration: BoxDecoration(
          border:
              outlined ? Border.all(color: color ?? AppColors.primary) : null,
          borderRadius: BorderRadius.circular(
            buttonSize == ButtonSize.small
                ? AppDimensions.buttonRadiusSmall
                : AppDimensions.buttonRadiusMedium,
          ),
          color: outlined ? null : color ?? AppColors.primary,
        ),
        child: Center(
          child: isLoading
              ? LoadingIndicator(
                  color: outlined ? AppColors.primary : Colors.white,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: iconAsset != null
                          ? [
                              SvgPicture.asset(
                                iconAsset!,
                                height: 18,
                              ),
                              AppDimensions.space(1)
                            ]
                          : [],
                    ),
                    Text(
                      text,
                      style: AppTextStyles.bodySmallBold.copyWith(
                        fontSize: buttonSize == ButtonSize.small ? 14 : null,
                        color: color ??
                            (outlined ? AppColors.primary : Colors.white),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
