
import 'package:flutter/cupertino.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/text.dart';

class FeedEmptyState extends StatelessWidget {
  const FeedEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("🔎", style: TextStyle(fontSize: 40)),
          AppDimensions.space(2),
          Text(
            "There is nothing to show!",
            style:
                AppTextStyles.bodySmallBold.copyWith(color: AppColors.primary),
          ),
          AppDimensions.space(1),
          Text(
            "Your list of followers is currently blank. Take a moment to discover and connect with some accounts to populate your follower list.",
            textAlign: TextAlign.center,
            style:
                AppTextStyles.bodyExtraSmall.copyWith(color: AppColors.gray100),
          ),
        ],
      ),
    ));
  }
}
