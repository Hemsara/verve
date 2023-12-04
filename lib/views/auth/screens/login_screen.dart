import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:verve/global/screens/scaffold.dart';
import 'package:verve/global/widgets/button.dart';
import 'package:verve/global/widgets/textfield.dart';
import 'package:verve/models/auth/user_auth.dart';
import 'package:verve/providers/auth/auth_provider.dart';
import 'package:verve/res/assets.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/res/navigator.dart';
import 'package:verve/res/notification.dart';

import 'package:verve/res/text.dart';
import 'package:verve/views/app/navbar.dart';
import 'package:verve/views/auth/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailCTRL;
  late TextEditingController passwordCTRL;

  @override
  void initState() {
    emailCTRL = TextEditingController();
    passwordCTRL = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailCTRL.dispose();
    passwordCTRL.dispose();

    super.dispose();
  }

  void handleLogin(
    UserLoginModel loginModel,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    AuthProvider provider = context.read<AuthProvider>();
    bool success = await provider.loginUser(loginModel);
    if (success) {
      NavigatorHelper.replaceAll(const NavbarPage());
      return;
    }
    if (mounted) {
      ToastManager.showErrorToast(context, provider.loginError!);
    }
  }

  final _formKey = GlobalKey<FormState>();

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
        Form(
          key: _formKey,
          child: Column(
            children: [
              VerveField(
                controller: emailCTRL,
                label: "E-mail address",
                textFieldType: TextFieldType.email,
                icon: Iconsax.user,
              ),
              VerveField(
                controller: passwordCTRL,
                label: "Password",
                textFieldType: TextFieldType.password,
                icon: Iconsax.key,
              ),
            ],
          ),
        ),
        AppDimensions.space(3),
        VerveButton(
          isLoading: context.watch<AuthProvider>().isLoginIn,
          text: "Login",
          onTap: () {
            handleLogin(
              UserLoginModel(
                  email: emailCTRL.text, password: passwordCTRL.text),
            );
          },
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
