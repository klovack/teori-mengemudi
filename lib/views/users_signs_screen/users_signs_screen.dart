import 'package:flutter/material.dart';
import 'package:roadcognizer/components/grid_signs/grid_signs.dart';

class UsersSignsScreen extends StatefulWidget {
  const UsersSignsScreen({super.key});

  @override
  State<UsersSignsScreen> createState() => _UsersSignsScreenState();
}

class _UsersSignsScreenState extends State<UsersSignsScreen> {
  var _isScrollingDown = false;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_isScrollingDown)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Signs you've taken so far",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            if (!_isScrollingDown) const SizedBox(height: 16),
            GridSigns(
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
