import 'package:flutter/material.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/text.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final double? radius;

  const Avatar({
    Key? key,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.radius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 20,
      backgroundColor: AppColors.primary.withOpacity(0.1),
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
              _getInitials(),
              style: AppTextStyles.bodyRegularBold.copyWith(
                  color: Colors.black.withOpacity(0.3),
                  fontSize: (radius ?? 20) / 1.3),
            )
          : null,
    );
  }

  String _getInitials() {
    String initials = '';
    if (firstName != null && firstName!.isNotEmpty) {
      initials += firstName![0];
    }
    if (lastName != null && lastName!.isNotEmpty) {
      initials += lastName![0];
    }
    return initials;
  }
}
