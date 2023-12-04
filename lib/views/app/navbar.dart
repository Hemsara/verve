import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:verve/res/colors.dart';
import 'package:verve/res/dimens.dart';
import 'package:verve/views/app/explore/screens/explore_screen.dart';
import 'package:verve/views/app/feed/screens/home_screen.dart';
import 'package:verve/views/app/profile/screens/profile_screen.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  get items => null;

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.defaultMargin,
            right: AppDimensions.defaultMargin,
            top: AppDimensions.defaultMargin,
          ),
          child: pages[selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.lovely,
              ),
              label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(
                Iconsax.save_2,
              ),
              label: "Collections"),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.profile_tick,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
