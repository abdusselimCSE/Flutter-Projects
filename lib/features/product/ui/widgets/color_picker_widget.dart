import 'package:flutter/material.dart';
import 'package:sum_app/app/app_colors.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget(
      {super.key, required this.colors, required this.onColorSelected});

  final List<String> colors;

  final Function(String) onColorSelected;

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: getColorItems(),
      ),
    );
  }

  List<Widget> getColorItems() {
    List<Widget> colorItemWidgetList = [];
    for (String color in widget.colors) {
      Widget item = getColorItemWidget(
        name: color,
        onTap: () {
          _selectedColor = color;
          widget.onColorSelected(_selectedColor!);
          setState(() {});
        },
        isSelected: _selectedColor == color,
      );
      colorItemWidgetList.add(item);
    }
    return colorItemWidgetList;
  }

  Widget getColorItemWidget({
    required String name,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        width: 48,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
          color: isSelected ? AppColors.themeColor : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: FittedBox(
          child: Text(
            name,
            style: TextStyle(
              color: isSelected ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
