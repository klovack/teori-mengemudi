import 'package:flutter/material.dart';
import 'package:roadcognizer/services/user/user.service.dart';

class DailyLimit extends StatefulWidget {
  const DailyLimit({super.key});

  @override
  State<DailyLimit> createState() => _DailyLimitState();
}

class _DailyLimitState extends State<DailyLimit> {
  int _limit = 0;
  int _currentCount = 0;

  @override
  void initState() {
    super.initState();

    _updateImageCount();
  }

  void _updateImageCount() async {
    final UserService userService = UserService();

    final int count =
        await userService.getCurrentUserImagesForLast(1).then((value) {
      return value.length;
    });

    final int limit =
        await userService.getCurrentUserImageLimit().then((value) {
      return value.value;
    });

    if (mounted) {
      setState(() {
        _currentCount = count;
        _limit = limit;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.all(16.0),
        child: Text(
          '${_limit - _currentCount} / $_limit',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ));
  }
}
