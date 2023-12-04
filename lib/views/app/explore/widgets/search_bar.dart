import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';

class ExploreSearchBar extends StatelessWidget {
  final Function(String) onSearchTyped;
  const ExploreSearchBar({
    Key? key,
    required this.onSearchTyped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.baseSize * 2),
      height: 45,
      decoration: BoxDecoration(
          color: AppColors.gray200.withOpacity(0.4),
          borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.search,
            color: AppColors.gray100,
          ),
          AppDimensions.space(2),
          Flexible(
            child: TextField(
              onChanged: onSearchTyped,
              decoration: const InputDecoration(
                hintText: "Search anything",
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
