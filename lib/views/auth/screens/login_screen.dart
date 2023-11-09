import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:verve/global/screens/scaffold.dart';
import 'package:verve/global/widgets/button.dart';
import 'package:verve/global/widgets/textfield.dart';
import 'package:verve/res/assets.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/navigator.dart';

import 'package:verve/res/text.dart';
import 'package:verve/views/auth/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BodyScaffold(
      centerAlign: true,
      children: [
        SvgPicture.asset(
          AppAssets.logo,
          height: 70,
          color: AppColors.primary,
        ),
        AppDimensions.space(2),
        Text(
          "Welcome Back",
          style: AppTextStyles.heading6Bold,
        ),
        AppDimensions.space(1),
        Text(
          "Sign in to your Verve account to continue sharing your stories and connecting with our community. Please enter your login details",
          style: AppTextStyles.bodyExtraSmall.copyWith(
            color: AppColors.gray100,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        AppDimensions.space(8),
        const VerveField(
          label: "E-mail address",
          textFieldType: TextFieldType.email,
          icon: Iconsax.user,
        ),
        const VerveField(
          label: "Password",
          textFieldType: TextFieldType.password,
          icon: Iconsax.key,
        ),
        AppDimensions.space(3),
        VerveButton(
          text: "Login",
          onTap: () {},
        ),
        AppDimensions.space(4),
        Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Don't have an account?",
                  style: AppTextStyles.bodySmall,
                ),
                WidgetSpan(
                  child: SizedBox(
                    width: AppDimensions.baseSize,
                  ),
                ),
                TextSpan(
                  text: "Create a one",
                  style: AppTextStyles.bodySmallMedium
                      .copyWith(color: AppColors.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      NavigatorHelper.replaceAll(const RegisterScreen());
                    },
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
