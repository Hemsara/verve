import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verve/global/widgets/button.dart';
import 'package:verve/models/user/account_user.dart';
import 'package:verve/providers/user/user_provider.dart';
import 'package:verve/res/assets.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/notification.dart';

class UserStats extends StatefulWidget {
  final AccountUser accountUser;
  final VoidCallback onFollowStateChanged;

  const UserStats({
    Key? key,
    required this.accountUser,
    required this.onFollowStateChanged,
  }) : super(key: key);

  @override
  State<UserStats> createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  bool updating = false;

  Future<void> handleFollowUnfollow() async {
    final provider = context.read<UserProvider>();

    setState(() {
      updating = true;
    });

    final success = await provider.makeProfileRequest(
      widget.accountUser.id,
      widget.accountUser.isFollowing,
    );

    setState(() {
      updating = false;
    });

    if (success && mounted) {
      final toastMessage = widget.accountUser.isFollowing
          ? "You unfollowed ${widget.accountUser.username}"
          : "You started following ${widget.accountUser.username}";

      ToastManager.showSuccessToast(context, toastMessage);

      widget.onFollowStateChanged();
      return;
    }

    if (mounted) {
      ToastManager.showErrorToast(
        context,
        provider.followUserError ?? "Unknown error occurred.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDimensions.space(4),
        Row(
          children: [
            Flexible(
              child: VerveButton(
                isLoading: updating,
                buttonSize: ButtonSize.small,
                iconAsset: widget.accountUser.isFollowing
                    ? AppAssets.followingLogo
                    : null,
                outlined: widget.accountUser.isFollowing ? true : false,
                text: widget.accountUser.isFollowing ? "Following" : "Follow",
                onTap: () {
                  handleFollowUnfollow();
                },
              ),
            ),
            AppDimensions.space(1),
            Flexible(
              child: VerveButton(
                buttonSize: ButtonSize.small,
                text: "Share Profile",
                outlined: true,
                onTap: () {},
              ),
            ),
          ],
        ),
        AppDimensions.space(3),
        const Divider(),
      ],
    );
  }
}
