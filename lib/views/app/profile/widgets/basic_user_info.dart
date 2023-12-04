import 'package:flutter/material.dart';

import 'package:verve/global/widgets/avatar.dart';

import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/text.dart';
import 'package:verve/views/app/profile/widgets/stats_widget.dart';

class BasicUserInfo extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String bio;
  final String followingCount;
  final String followersCount;
  final String articlesCount;

  final String? profilePicture;

  const BasicUserInfo({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.followingCount,
    required this.followersCount,
    required this.articlesCount,
    required this.profilePicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Avatar(
              imageUrl: profilePicture,
              radius: (40),
              firstName: firstName,
              lastName: lastName,
            ),
            AppDimensions.space(2),
            Column(
              children: [
                Text(
                  "$firstName $lastName",
                  style: AppTextStyles.bodyRegularMedium,
                ),
                Text(
                  bio,
                  style: AppTextStyles.bodyExtraSmall
                      .copyWith(color: AppColors.gray100),
                ),
              ],
            )
          ],
        ),
        AppDimensions.space(3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StatsWidget(count: followingCount, label: "Following"),
            StatsWidget(count: followersCount, label: "Followers"),
            StatsWidget(count: articlesCount, label: "Articles"),
          ],
        ),
        AppDimensions.space(3),
        const Divider(),
      ],
    );
  }
}
