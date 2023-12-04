
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/text.dart';

class ProfilePostWidget extends StatelessWidget {
  const ProfilePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppDimensions.defaultMargin),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.gray200),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.calendar,
                          color: AppColors.gray100,
                          size: 15,
                        ),
                        AppDimensions.space(1),
                        Text(
                          "On 2023 July 14".toUpperCase(),
                          style: AppTextStyles.bodyExtraSmall
                              .copyWith(color: AppColors.gray100),
                        ),
                      ],
                    ),
                    AppDimensions.space(2),
                    Text(
                      "What is new on flutter 3.7".toUpperCase(),
                      style: AppTextStyles.bodySmallBold,
                    ),
                    AppDimensions.space(1),
                    Text(
                      "Discover the essence of product design in our blog...",
                      style: AppTextStyles.bodyExtraSmall
                          .copyWith(color: AppColors.gray100),
                    ),
                  ],
                ),
              ),
              AppDimensions.space(2),
              Flexible(
                child: Container(
                  height: 90,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1542435503-956c469947f6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjZ8fGRlc2lnbnxlbnwwfHwwfHx8MA%3D%3D"),
                        fit: BoxFit.cover),
                  ),
                ),
              )
            ],
          ),
          AppDimensions.space(2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.redAccent,
                    size: 15,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    "12,500",
                    style: AppTextStyles.bodyExtraSmallBold
                        .copyWith(color: Colors.redAccent),
                  ),
                ],
              ),
              const Icon(
                Iconsax.save_add,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
