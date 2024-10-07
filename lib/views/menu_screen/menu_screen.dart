import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';
import 'package:roadcognizer/views/quiz/quiz.dart';
import 'package:roadcognizer/views/take_picture_screen/take_picture_screen.dart';
import 'package:roadcognizer/views/users_signs_screen/users_signs_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var _activeScreen = NavbarDestinations.signs;
  var _isNavbarVisible = true;
  var _isAppBarVisible = true;
  var _userSignsKey = UniqueKey();

  Future<void> _navigateToSignRecognizer() async {
    final cameras = await availableCameras();

    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(
          cameras: cameras,
        ),
      ),
    );

    setState(() {
      _userSignsKey = UniqueKey();
    });
  }

  void _setNavAndAppBarVisibility(bool isVisible) {
    setState(() {
      _isNavbarVisible = isVisible;
      _isAppBarVisible = isVisible;
    });
  }

  Widget get _getActiveScreen {
    switch (_activeScreen) {
      case NavbarDestinations.quiz:
        return QuizScreen(
          onQuizStart: () => _setNavAndAppBarVisibility(false),
          onQuizEnd: () => _setNavAndAppBarVisibility(true),
        );
      case NavbarDestinations.signs:
        return UsersSignsScreen(
          key: _userSignsKey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isNavbarVisible: _isNavbarVisible,
      isAppBarVisible: _isAppBarVisible,
      selectedDestination: _activeScreen,
      onReadTrafficSignsTap: _navigateToSignRecognizer,
      onNavbarSelected: (destination) {
        setState(() {
          _activeScreen = destination;
        });
      },
      body: _getActiveScreen,
    );
  }
}
