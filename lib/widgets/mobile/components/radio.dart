import 'package:flutter/material.dart';
import 'package:wedding/data/colors.dart';

class WeddingRadio<T> extends StatelessWidget {
  final List<T> children;
  final String Function(T) labelBuilder;
  final T selected;
  final void Function(T)? onTap;
  const WeddingRadio({
    Key? key,
    required this.children,
    required this.labelBuilder,
    required this.selected,
    this.onTap,
  }) : super(key: key);

  Widget buildChild(T child) {
    final isSelected = child == selected;
    return GestureDetector(
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: isSelected ? null : Border.all(color: textColor),
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? secondaryColor : Colors.transparent,
            ),
            height: 20,
            margin: const EdgeInsets.all(8),
            width: 20,
          ),
          Text(labelBuilder(child), style: TextStyle(color: isSelected ? secondaryColor : textColor, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(width: 20),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      onTap: () {
        onTap?.call(child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: children.map((child) => buildChild(child)).toList(),
    );
  }
}
