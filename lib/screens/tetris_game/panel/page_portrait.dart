import 'dart:math';

import 'package:tetris/generated/locales.g.dart';
import 'package:tetris/screens/tetris_game/panel/word_button.dart';
import 'package:tetris/theme/colors.dart';
import 'package:tetris/theme/text_theme.dart';
import 'package:tetris/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../gamer/constants.dart';
import '../gamer/game_state.dart';
import '../gamer/gamer.dart';
import '../gamer/keyboard.dart';
import 'controller.dart';
import 'screen.dart';

part 'page_land.dart';

class TetrisGameScreenBinding extends Bindings {
  @override
  void dependencies() {
    GameConstants.genWordParts(['tetris', 'game', 'fun', 'flutter']);
  }
}

class TetrisGame extends StatelessWidget {
  const TetrisGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Game(child: KeyboardController(child: PagePortrait())),
    );
  }
}

class PagePortrait extends StatelessWidget {
  const PagePortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenW = GameConstants.getGameScreenWidth(context);

    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: const BoxDecoration(gradient: GPColor.bgGradient4),
        )),
        SizedBox.expand(
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: Column(
              children: <Widget>[
                Screen(width: screenW),
                Expanded(
                    child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () => Game.of(context).pauseOrResume(),
                      child: Container(
                        width: min(50.h375, 70),
                        height: min(50.h375, 70),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Icon(
                            GameState.of(context).states == GameStates.running
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 30.h375,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.game_tetris_listWords.tr.toUpperCase(),
                            style: textStyle(GPTypography.body16)
                                ?.mergeFontSize(14.sp)
                                .mergeFontWeight(FontWeight.w700)
                                .white(),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Wrap(
                              spacing: 12,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: GameConstants.LIST_WORDS
                                  .map(
                                      (e) => WordButton(title: e.toUpperCase()))
                                  .toList()),
                        ],
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
