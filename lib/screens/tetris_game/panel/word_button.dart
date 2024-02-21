import 'package:tetris/theme/colors.dart';
import 'package:tetris/theme/text_theme.dart';
import 'package:tetris/utils/utils.dart';
import 'package:flutter/material.dart';

class WordButton extends StatelessWidget {
  final String title;

  const WordButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
          color: GPColor.bgPrimary, borderRadius: BorderRadius.circular(4)),
      child: Text(
        title,
        style: textStyle(GPTypography.bodyMedium)
            ?.mergeColor(GPColor.contentPrimary)
            .mergeFontSize(10.sp)
            .mergeFontWeight(FontWeight.w900),
      ),
    );
  }
}
