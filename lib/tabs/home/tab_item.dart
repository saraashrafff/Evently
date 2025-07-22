import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  String label;
  IconData icon;
  bool isSelected;
  Color selectedBackgroundColor;

  Color selectedForegroundColor;
  Color unSelectedForegroundColor;

  TabItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.selectedForegroundColor,
    required this.unSelectedForegroundColor,
    required this.selectedBackgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: isSelected ? null : Border.all(color: selectedBackgroundColor),
        color: isSelected ? selectedBackgroundColor : Colors.transparent,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected
                ? selectedForegroundColor
                : unSelectedForegroundColor,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextTheme.of(context).titleMedium!.copyWith(
              color: isSelected
                  ? selectedForegroundColor
                  : unSelectedForegroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
