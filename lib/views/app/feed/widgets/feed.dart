import 'package:flutter/cupertino.dart';
import 'package:verve/global/widgets/button.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/text.dart';
import 'package:verve/views/app/feed/widgets/empty_state.dart';
import 'package:verve/views/app/feed/widgets/post_widget.dart';

class FeedItems extends StatelessWidget {
  const FeedItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    // hardcode this variable just for now
    return Expanded(
      child: isEmpty
          ? const FeedEmptyState()
          : ListView(
              children: const [
                PostWidget(),
                PostWidget(),
                PostWidget(),
              ],
            ),
    );
  }
}
