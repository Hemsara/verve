import 'package:flutter/cupertino.dart';
import 'package:verve/models/post/post.dart';
import 'package:verve/views/app/profile/widgets/profile_post_widget.dart';

class UserPosts extends StatelessWidget {
  final List<Post> posts;
  const UserPosts({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: posts.isEmpty
          ? const Center(
              child: Text("This user haven't posted anything yet"),
            )
          : ListView(
              children: const [
                ProfilePostWidget(),
                ProfilePostWidget(),
                ProfilePostWidget(),
                ProfilePostWidget(),
              ],
            ),
    );
  }
}
