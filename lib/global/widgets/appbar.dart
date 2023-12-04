import 'package:flutter/material.dart';

import 'package:verve/res/dimens.dart';
import 'package:verve/res/navigator.dart';
import 'package:verve/res/text.dart';

class VerveAppBar extends StatelessWidget {
  final String text;
  final List<Widget>? actions;

  const VerveAppBar({
    Key? key,
    required this.text,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              child: NavigatorHelper.navigatorKey.currentState!.canPop()
                  ? GestureDetector(
                      onTap: () {
                        NavigatorHelper.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 25,
                      ))
                  : null,
            ),
            AppDimensions.space(2),
            Text(
              text,
              style: AppTextStyles.bodyRegularSemibold,
            ),
          ],
        ),
        Row(
          children: actions ?? [],
        )
      ],
    );
  }
}
