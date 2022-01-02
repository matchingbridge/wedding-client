import 'package:flutter/material.dart';
import 'package:wedding/data/colors.dart';

class WeddingSelect<T> extends StatelessWidget {
  final List<T> children;
  final List<T> selected;
  final String Function(T) labelBuilder;
  final void Function(T)? onTap;
  const WeddingSelect({
    Key? key, 
    required this.children,
    required this.selected,
    required this.labelBuilder,
    this.onTap,
  }) : super(key: key);

  Widget buildChild(T child) {
    final isSelected = selected.contains(child);
    return GestureDetector(
      child: Container(
        child: Text(labelBuilder(child), style: TextStyle(color: isSelected ? secondaryColor : textColor),),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? secondaryColor : textColor),
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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