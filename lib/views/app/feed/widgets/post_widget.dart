import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/text.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;
  bool isLiked = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bounceAnimation = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.3),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.3, end: 1.0),
          weight: 1,
        ),
      ],
    ).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.baseSize),
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            isLiked = !isLiked;
          });
          _animationController.forward(from: 0.0);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppDimensions.defaultMargin),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(AppDimensions.buttonRadiusMedium),
            border: Border.all(
              color: AppColors.gray100.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              AppDimensions.space(2),
              thumbnail(),
              AppDimensions.space(2),
              Text(
                "The art of product designing",
                style: AppTextStyles.bodyRegularBold,
              ),
              AppDimensions.space(1),
              Text(
                "Discover the essence of product design in our blog,where creativity meets functionality for innovative, visually striking results",
                style: AppTextStyles.bodyExtraSmall
                    .copyWith(color: AppColors.gray100),
              ),
              AppDimensions.space(1),
              const Divider(),
              AppDimensions.space(1),
              likesAndReactions()
            ],
          ),
        ),
      ),
    );
  }

  Row likesAndReactions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Row(
              children: [
                ScaleTransition(
                  scale: _bounceAnimation,
                  child: Icon(
                    isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    color: Colors.redAccent,
                    size: 18,
                  ),
                ),
                AppDimensions.space(1),
                Text(
                  "135,000",
                  style: AppTextStyles.bodyExtraSmallBold
                      .copyWith(color: Colors.redAccent),
                ),
              ],
            ),
            AppDimensions.space(2),
            Row(
              children: [
                Icon(
                  Iconsax.message_2,
                  size: 18,
                  color: AppColors.gray100,
                ),
                AppDimensions.space(1),
                Text(
                  "184",
                  style: AppTextStyles.bodyExtraSmallBold.copyWith(
                    color: AppColors.gray100,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Icon(
          Iconsax.send_2,
          size: 20,
        )
      ],
    );
  }

  Row header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/79366878?v=4"),
            ),
            AppDimensions.space(1),
            Text(
              "Vehan Hemsara",
              style: AppTextStyles.bodySmallMedium,
            )
          ],
        ),
        const Icon(
          Iconsax.save_2,
          size: 20,
        )
      ],
    );
  }
}

Widget thumbnail() {
  return Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
        image: const DecorationImage(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1542435503-956c469947f6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjZ8fGRlc2lnbnxlbnwwfHwwfHx8MA%3D%3D"),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(AppDimensions.buttonRadiusMedium)),
  );
}
