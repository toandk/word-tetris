import 'package:tetris/screens/loading/loading_screen.dart';
import 'package:tetris/screens/tetris_game/panel/page_portrait.dart';
import 'package:get/get.dart';
import 'router_name.dart';

class Pages {
  static List<GetPage> pages = [
    GetPage(
        name: RouterName.loading,
        transitionDuration: Duration.zero,
        page: () => LoadingScreen()),
    GetPage(
        name: RouterName.gameTetris,
        page: () => const TetrisGame(),
        binding: TetrisGameScreenBinding()),
  ];
}
