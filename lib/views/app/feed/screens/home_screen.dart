import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:verve/global/widgets/appbar.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/views/app/feed/widgets/feed.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerveAppBar(
          text: "Feed",
          actions: [
            const Icon(
              Iconsax.notification,
            ),
            AppDimensions.space(2),
            const Icon(
              Iconsax.add,
              size: 30,
            ),
          ],
        ),
        AppDimensions.space(3),
        const FeedItems(),
      ],
    );
  }
}
