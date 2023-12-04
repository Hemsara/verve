import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verve/global/widgets/appbar.dart';
import 'package:verve/global/widgets/error_info.dart';
import 'package:verve/global/widgets/loading_indicator.dart';
import 'package:verve/models/user/account_user.dart';
import 'package:verve/providers/user/user_provider.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/views/app/explore/widgets/user_stats.dart';
import 'package:verve/views/app/profile/widgets/basic_user_info.dart';
import 'package:verve/views/app/profile/widgets/user_post_section.dart';

class UserProfilePreviewScreen extends StatefulWidget {
  final int userId;

  const UserProfilePreviewScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<UserProfilePreviewScreen> createState() =>
      _UserProfilePreviewScreenState();
}

class _UserProfilePreviewScreenState extends State<UserProfilePreviewScreen> {
  Key futureBuilderKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: AppDimensions.defaultMargin,
          right: AppDimensions.defaultMargin,
        ),
        child: SafeArea(
          bottom: false,
          child: FutureBuilder<AccountUser?>(
            key: futureBuilderKey,
            // Fetch user information using the UserProvider
            future: context.read<UserProvider>().getUserInfo(widget.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // loading indicator while waiting for data
                return const LoadingIndicator(color: Colors.black);
              } else if (snapshot.hasData && snapshot.data != null) {
                // Display user profile information
                return Column(
                  children: [
                    const VerveAppBar(
                      text: "Profile",
                      actions: [],
                    ),
                    AppDimensions.space(5),
                    // Basic user information section
                    BasicUserInfo(
                      firstName: snapshot.data!.firstName,
                      lastName: snapshot.data!.lastName,
                      bio: snapshot.data!.bio ?? "",
                      followingCount: snapshot.data!.followingCount.toString(),
                      followersCount: snapshot.data!.followersCount.toString(),
                      articlesCount: snapshot.data!.posts.length.toString(),
                      profilePicture: snapshot.data!.profilePicture,
                    ),

                    UserStats(
                      onFollowStateChanged: () {
                        // rebuild when follow state changes
                        setState(() {
                          futureBuilderKey = UniqueKey();
                        });
                      },
                      accountUser: snapshot.data!,
                    ),
                    // User posts section
                    UserPosts(posts: snapshot.data!.posts),
                  ],
                );
              }

              return const ErrorInfo();
            },
          ),
        ),
      ),
    );
  }
}
