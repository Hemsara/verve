import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:verve/global/widgets/avatar.dart';

import 'package:verve/models/user/user_search_result.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/navigator.dart';
import 'package:verve/res/text.dart';
import 'package:verve/views/app/profile/screens/user_profile_preview.dart';

class UserExploreWidget extends StatelessWidget {
  final UserSearchResult searchResult;
  const UserExploreWidget({
    Key? key,
    required this.searchResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          NavigatorHelper.to(
            UserProfilePreviewScreen(
              userId: searchResult.id,
            ),
          );
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Avatar(
                      imageUrl: searchResult.avatar,
                      radius: 15,
                      firstName: searchResult.firstName,
                      lastName: searchResult.lastName,
                    ),
                    AppDimensions.space(1),
                    Text(
                      "${searchResult.firstName} ${searchResult.lastName}",
                      style: AppTextStyles.bodySmallMedium,
                    )
                  ],
                ),
                Icon(
                  CupertinoIcons.arrow_turn_up_right,
                  color: AppColors.gray100.withOpacity(0.5),
                  size: 19,
                )
              ],
            ),
            AppDimensions.space(1),
            const Divider()
          ],
        ),
      ),
    );
  }
}
