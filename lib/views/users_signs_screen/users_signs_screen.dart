import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/grid_signs/grid_signs.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/services/user/user.service.dart';

class UsersSignsScreen extends StatefulWidget {
  const UsersSignsScreen({super.key});

  @override
  State<UsersSignsScreen> createState() => _UsersSignsScreenState();
}

class _UsersSignsScreenState extends State<UsersSignsScreen> {
  var _isScrollingDown = false;
  final userService = UserService();
  List<TrafficSignImage>? _images;

  @override
  void initState() {
    super.initState();

    userService.getCurrentUserImages(limit: 8).then((images) {
      setState(() {
        _images = images;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _images != null && _images!.isEmpty
          ? Center(
              child: Text(
                context.tr('userSigns.empty'),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isScrollingDown)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                      child: Text(context.tr('userSigns.title'),
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            if (!_isScrollingDown) const SizedBox(height: 16),
            GridSigns(
                    images: _images,
              onScrollDown: () => setState(() {
                _isScrollingDown = true;
              }),
              onScrollUp: () => setState(() {
                _isScrollingDown = false;
              }),
            ),
                ],
        ),
      ),
    );
  }
}
