import 'package:flutter/material.dart';
import 'package:tetris/theme/colors.dart';
import 'package:tetris/theme/text_theme.dart';
import 'package:tetris/utils/utils.dart';
import 'package:flutter/src/services/system_chrome.dart';

import 'bottom_shadow_decoration.dart';

class MJAppBar extends AppBar {
  final bool hasBack;
  final bool isWhite;
  final bool bottomShadow;
  final String titleString;
  @override
  final Color? backgroundColor;
  final PreferredSizeWidget? bottomWidget;
  final List<Widget>? rightViews;
  MJAppBar(
      {Key? key,
      this.hasBack = true,
      this.isWhite = true,
      this.titleString = '',
      this.backgroundColor,
      this.bottomShadow = false,
      this.bottomWidget,
      this.rightViews,
      SystemUiOverlayStyle? systemOverlayStyle})
      : super(
            key: key,
            systemOverlayStyle: systemOverlayStyle,
            elevation: 0,
            backgroundColor: backgroundColor ??
                (isWhite ? GPColor.bgPrimary : Colors.transparent),
            bottom: bottomShadow
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(8),
                    child: Container(
                        height: 8, decoration: BottomShadowDecoration()))
                : bottomWidget,
            actions: rightViews,
            leading: hasBack
                ? BackButton(
                    color: isWhite
                        ? GPColor.contentPrimary
                        : GPColor.contentInversePrimary)
                : Container(),
            title: Text(
              titleString,
              style: textStyle(GPTypography.h2)
                  ?.mergeFontSize(Utils.isSmallDevice() ? 18 : 20.sp)
                  .mergeColor(isWhite
                      ? GPColor.contentPrimary
                      : GPColor.contentInversePrimary),
              textAlign: TextAlign.center,
            ));
}
