import 'package:tetris/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tetris/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'generated/locales.g.dart';
import 'routes/routes.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  await GetStorage.init();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  if (GetPlatform.isAndroid) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  runApp(MyApp(savedThemeMode: savedThemeMode));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: AppThemes.lightTheme(),
        dark: AppThemes.darktheme(),
        debugShowFloatingThemeButton: false,
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => RefreshConfiguration(
            hideFooterWhenNotFull: true,
            child: RefreshConfiguration(
                headerBuilder: () => const WaterDropMaterialHeader(
                      color: Colors.white,
                      backgroundColor: Colors.orange,
                    ),
                child: GetMaterialApp(
                  theme: theme,
                  darkTheme: darkTheme,
                  locale: const Locale('en'),
                  fallbackLocale: const Locale("en"),
                  supportedLocales: const [
                    Locale("en"),
                    Locale("vi"),
                  ],
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  translationsKeys: AppTranslation.translations,
                  initialRoute: RouterName.gameTetris,
                  debugShowCheckedModeBanner: false,
                  navigatorObservers: [routeObserver],
                  getPages: Pages.pages,
                  routingCallback: (value) {
                    if (value == null ||
                        value.isBottomSheet == true ||
                        value.isDialog == true) return;
                    Utils.trackScreen(value.current);
                  },
                  builder: EasyLoading.init(),
                ))));
  }
}
