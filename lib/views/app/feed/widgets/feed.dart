import 'package:flutter/cupertino.dart';
import 'package:verve/views/app/feed/widgets/empty_state.dart';
import 'package:verve/views/app/feed/widgets/post_widget.dart';

class FeedItems extends StatelessWidget {
  const FeedItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
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
