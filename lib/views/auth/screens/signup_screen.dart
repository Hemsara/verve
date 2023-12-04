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
import 'package:verve/views/auth/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  late TextEditingController passwordController;
  late TextEditingController emailController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    passwordController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();

    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void handleRegister(
    UserRegisterModel registerModel,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    AuthProvider provider = context.read<AuthProvider>();

    bool success = await provider.registerUser(registerModel);

    if (success) {
      NavigatorHelper.replaceAll(const LoginScreen());
      return;
    }
    if (mounted) {
      ToastManager.showErrorToast(context, provider.signUpError!);
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
          "Welcome to Verve",
          style: AppTextStyles.heading6Bold,
        ),
        AppDimensions.space(1),
        Text(
          "Create your Verve account to start sharing your thoughts and stories with the world",
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
              Row(
                children: [
                  Flexible(
                    child: VerveField(
                      controller: firstNameController,
                      label: "First name",
                      textFieldType: TextFieldType.text,
                      icon: Iconsax.user,
                    ),
                  ),
                  AppDimensions.space(1),
                  Flexible(
                    child: VerveField(
                      controller: lastNameController,
                      label: "Last name",
                      textFieldType: TextFieldType.text,
                      icon: Iconsax.user,
                    ),
                  ),
                ],
              ),
              VerveField(
                controller: emailController,
                label: "E-mail address",
                textFieldType: TextFieldType.email,
                icon: Iconsax.user,
              ),
              VerveField(
                controller: passwordController,
                label: "Password",
                textFieldType: TextFieldType.password,
                icon: Iconsax.key,
              ),
            ],
          ),
        ),
        AppDimensions.space(3),
        VerveButton(
          isLoading: context.watch<AuthProvider>().isSignInIn,
          text: "Create account",
          onTap: () {
            handleRegister(
              UserRegisterModel(
                password: passwordController.text,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
              ),
            );
          },
        ),
        AppDimensions.space(4),
        Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Already have an account?",
                  style: AppTextStyles.bodySmall,
                ),
                WidgetSpan(
                  child: SizedBox(
                    width: AppDimensions.baseSize,
                  ),
                ),
                TextSpan(
                  text: "Login now",
                  style: AppTextStyles.bodySmallMedium
                      .copyWith(color: AppColors.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      NavigatorHelper.replaceAll(const LoginScreen());
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
