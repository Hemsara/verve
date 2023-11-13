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
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;

  @override
  void initState() {
    nameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  bool signingUp = false;

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void handleRegister(UserRegisterModel registerModel) async {
    if (_formKey.currentState!.validate()) {
      if (signingUp) {
        return;
      }
      setState(() {
        signingUp = true;
      });

      AuthProvider provider = context.read<AuthProvider>();

      bool success = await provider.registerUser(registerModel);
      setState(() {
        signingUp = false;
      });
      if (success) {
        NavigatorHelper.replaceAll(const LoginScreen());
        return;
      }
      if (mounted) {
        ToastManager.showErrorToast(context, provider.signUpError!);
      }
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
              VerveField(
                controller: nameController,
                label: "Full name",
                textFieldType: TextFieldType.text,
                icon: Iconsax.user,
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
          isLoading: signingUp,
          text: "Create account",
          onTap: () {
            handleRegister(
              UserRegisterModel(
                password: passwordController.text,
                fullName: nameController.text,
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
