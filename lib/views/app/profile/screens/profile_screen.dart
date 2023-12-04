import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:verve/global/widgets/appbar.dart';
import 'package:verve/global/widgets/error_info.dart';

import 'package:verve/global/widgets/loading_indicator.dart';
import 'package:verve/providers/user/user_provider.dart';

import 'package:verve/res/dimens.dart';

import 'package:verve/views/app/profile/widgets/user_post_section.dart';
import 'package:verve/views/app/profile/widgets/basic_user_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<UserProvider>().getCurrentUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, snapshot, _) {
      return Column(
        children: snapshot.currentUser == null
            ? [
                Expanded(
                  child: Center(
                    child: snapshot.currentUserFetching
                        ? const LoadingIndicator(
                            color: Colors.black,
                          )
                        : ErrorInfo(text: snapshot.currentUserFetchingError!),
                  ),
                )
              ]
            : [
                VerveAppBar(
                  actions: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Iconsax.edit_2))
                  ],
                  text: "Profile",
                ),
                AppDimensions.space(2),
                BasicUserInfo(
                  bio: snapshot.currentUser!.bio ?? "",
                  firstName: snapshot.currentUser!.firstName,
                  lastName: snapshot.currentUser!.lastName,
                  followingCount:
                      snapshot.currentUser!.followingCount.toString(),
                  followersCount:
                      snapshot.currentUser!.followersCount.toString(),
                  articlesCount: snapshot.currentUser!.posts.length.toString(),
                  profilePicture: snapshot.currentUser!.profilePicture,
                ),
                const UserPosts(
                  posts: [],
                )
              ],
      );
    });
  }
}
