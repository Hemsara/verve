import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:verve/providers/auth/auth_provider.dart';
import 'package:verve/providers/user/user_provider.dart';
import 'package:verve/res/navigator.dart';
import 'package:verve/views/app/navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: const VerveApp(),
    ),
  );
}

class VerveApp extends StatelessWidget {
  const VerveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        navigatorKey: NavigatorHelper.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
        ),
        home: const NavbarPage(),
      ),
    );
  }
}
