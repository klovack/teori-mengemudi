import 'package:flutter/material.dart';
import 'package:roadcognizer/theme/brand_colors.dart';
import 'package:roadcognizer/views/profile_screen/profile_screen.dart';

enum NavbarDestinations {
  signs(0),
  quiz(1);

  const NavbarDestinations(this.value);
  final int value;
}

class AppScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;

  final Function()? onReadTrafficSignsTap;
  final Function(NavbarDestinations selectedIndex)? onNavbarSelected;
  final NavbarDestinations selectedDestination;
  final bool isNavbarVisible;
  final bool isAppBarVisible;

  const AppScaffold({
    super.key,
    required this.body,
    this.onReadTrafficSignsTap,
    this.onNavbarSelected,
    this.selectedDestination = NavbarDestinations.signs,
    this.isNavbarVisible = true,
    this.isAppBarVisible = true,
    this.appBar,
  });

  Widget? get _bottomNavigationBar {
    if (isNavbarVisible) {
      return BottomAppBar(
        padding: const EdgeInsets.all(0),
        shape: const CircularNotchedRectangle(),
        height: 70,
        notchMargin: 12,
        child: NavigationBar(
          onDestinationSelected: onNavbarSelected != null
              ? (index) => onNavbarSelected!(NavbarDestinations.values[index])
              : null,
          selectedIndex: selectedDestination.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.image_search, size: 24),
              label: "Signs",
            ),
            NavigationDestination(
              icon: Icon(Icons.traffic),
              label: "Quiz",
            ),
          ],
        ),
      );
    }
    return null;
  }

  Widget? get _readTrafficSignFloatingActionButton {
    if (isNavbarVisible) {
      return FloatingActionButton(
        onPressed: onReadTrafficSignsTap,
        shape: const CircleBorder(
          side: BorderSide(
            color: BrandColors.red,
            width: 8,
            strokeAlign: 0,
          ),
        ),
        child: const Icon(Icons.add_road),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _getAppBar(context),
      bottomNavigationBar: _bottomNavigationBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _readTrafficSignFloatingActionButton,
      body: body,
    );
  }

  AppBar? _getAppBar(BuildContext context) {
    if (!isAppBarVisible) {
      return null;
    }

    return AppBar(
      title: const Text("Roadcognizer"),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Image.asset('assets/images/logo.png', width: 30),
      ),
      scrolledUnderElevation: 0,
      leadingWidth: 50,
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
