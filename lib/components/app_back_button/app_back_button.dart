import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final Function(BuildContext)? navigateBack;
  final Color iconColor;
  final AlignmentGeometry alignment;
  final IconData icon;

  const AppBackButton({
    super.key,
    this.navigateBack,
    this.iconColor = Colors.white,
    this.alignment = Alignment.topLeft,
    this.icon = Icons.arrow_back,
  });

  void defaultNavigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: alignment,
        child: IconButton(
          onPressed: () => navigateBack != null
              ? navigateBack!(context)
              : defaultNavigateBack(context),
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(10),
            elevation: 10,
          ),
          icon: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
