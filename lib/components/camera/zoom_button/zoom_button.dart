import 'package:flutter/material.dart';
import 'package:roadcognizer/theme/fonts.dart';
import 'package:collection/collection.dart';

class ZoomButtons extends StatefulWidget {
  final List<double> zoomLevels;
  final int initialSelectedIndex;
  final Function(double) onZoomLevelChange;

  const ZoomButtons(
      {super.key,
      required this.onZoomLevelChange,
      this.zoomLevels = const [1.0, 2.0, 3.0],
      this.initialSelectedIndex = 0});

  @override
  State<ZoomButtons> createState() => _ZoomButtonsState();
}

class _ZoomButtonsState extends State<ZoomButtons> {
  late int _selectedZoomLevelIndex;

  @override
  void initState() {
    super.initState();

    _selectedZoomLevelIndex = widget.initialSelectedIndex;
    widget.onZoomLevelChange(widget.zoomLevels[_selectedZoomLevelIndex]);
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedZoomLevelIndex >= widget.zoomLevels.length) {
      setState(() {
        _selectedZoomLevelIndex = 0;
      });
      widget.onZoomLevelChange(widget.zoomLevels[0]);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.zoomLevels.mapIndexed(
        (i, zoomLevel) {
          return ZoomButton(
            onTap: () {
              setState(() {
                _selectedZoomLevelIndex = i;
                widget.onZoomLevelChange(zoomLevel);
              });
            },
            isSelected: i == _selectedZoomLevelIndex,
            zoomLevel: zoomLevel,
          );
        },
      ).toList(),
    );
  }
}

class ZoomButton extends StatelessWidget {
  final Function()? onTap;
  final double zoomLevel;
  final bool isSelected;

  const ZoomButton(
      {super.key,
      required this.onTap,
      required this.zoomLevel,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.black.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
        child: Text(
          zoomLevel.toStringAsFixed(1),
          style: Fonts.getSecondary(
            ts: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
