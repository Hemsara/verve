import 'package:flutter/widgets.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/text.dart';

class StatsWidget extends StatelessWidget {
  final String count;
  final String label;
  const StatsWidget({super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: AppTextStyles.bodyRegularBold,
        ),
        Text(
          label.toUpperCase(),
          style:
              AppTextStyles.bodyExtraSmall.copyWith(color: AppColors.gray100),
        ),
      ],
    );
  }
}
