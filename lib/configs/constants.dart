import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Environment { staging, production }

Environment env = Environment.staging;

class Constants {
  /// APP CONFIG
  static const String appName = "DeliEn";
  static const String baseUrl = "https://yourdomain.com/";

  static const String appSchema = "com.delien.app://";

  static const String appUrl = "https://delien.com/install";
  static const String authRedirectUri = "com.delien.app://login-callback/";

  static const supportEmail = "deliencontact@gmail.com";

  static String revenueCatAPIKey = GetPlatform.isAndroid
      ? 'goog_FJjgZVJzizwVeKDNklNwncgeDPa'
      : 'appl_wVXxqQTdaVTTAZpMTcnKeAcUVJg';

  static const String premiumEntitlement = 'premium';

  static final Image lessonPlaceholder =
      Image.asset('assets/images/lesson3.jpg', fit: BoxFit.cover);
  static final Image lessonPlaceholder2 =
      Image.asset('assets/images/lesson4.jpg', fit: BoxFit.cover);
  static final Image collectionPlaceholder =
      Image.asset('assets/images/learn1.jpg', fit: BoxFit.cover);
  static final Image categoryPlaceholder =
      Image.asset('assets/images/learn1.jpg', fit: BoxFit.cover);
  static final Image spellingGamePlaceholder =
      Image.asset('assets/images/spelling_game.jpg', fit: BoxFit.cover);
  static final Image listeningGamePlaceholder =
      Image.asset('assets/images/listening_game.jpg', fit: BoxFit.cover);
  static final Image tetrisGamePlaceholder =
      Image.asset('assets/images/tetris_game.jpg', fit: BoxFit.cover);
  static final Image defaultAvatar =
      Image.asset('assets/images/spelling_game.jpg', fit: BoxFit.cover);

  static Image getLessonPlaceholder(String id) {
    if (id.substring(0, 1).toLowerCase().compareTo('i') == -1) {
      return lessonPlaceholder;
    }
    return lessonPlaceholder2;
  }

  static const double kLoadMoreOffset = 100;

  static const int maxTipShowForEachExercise = 4;

  static const int maxFreeCreatableGames = 3;
  static const int maxFreeCreatableLessons = 2;

  static const coin1AddressMain = "0xFD626E4c00B59AFCAFd0F47F743051A58BCc4A62";
  static const coin2AddressMain = "0xE904A243c4D697C12a5DcB96286Ac77F9ABD9628";

  static const coin1AddressTest = "0xA877Dbf99A7395DBd4624Ce30eA7DC5d329e1ec4";
  static const coin2AddressTest = "0x75b1051F9dc4De55570C3198b18Ecf2458d9Aa91";

  static String coin1Address =
      env == Environment.staging ? coin1AddressTest : coin1AddressMain;
  static String coin2Address =
      env == Environment.staging ? coin2AddressTest : coin2AddressMain;

  static const String agreementUrl = 'https://delien-landing.web.app/terms';
  static const String policyUrl = 'https://delien-landing.web.app/privacy';

  /// CUSTOM CONFIG APP
  static const String languageKey = 'LANGUAGE';

  static String apiDomain = env == Environment.staging
      ? "https://api-testnet.jumpz.vkro.vn/"
      : 'https://api-testnet.jumpz.vkro.vn/';

  static String requestEmailOTP = "auth/otp";
  static String loginWithOTP = "auth/login";
  static String loginWithPassword = "auth/login_by_password";
  static String renewTokenPath = "auth/otp";
  static String getUserInfo = "accounts/me";
  static String activateCode = "auth/activate";
  static String getCode = "auth/get_code";
  static String bindWallet = "accounts/bind_on_chain_wallet";
  static String newSession = "sessions/new";
  static String currentSession = "sessions/active_current";
  static String endSession = "sessions/end";
  static String sessionMetrics = "sessions/metrics";
  static String setPassword = "auth/password";

  static String searchMarket = "nft_market/search";
  static String buyNft = "nft_market/buy";
  static String sellNft = "nft_market/sell";
  static String openNft = "nft_inventory/open";

  static int maxOTPTime = 60;

  static int minPasswordLength = 6;

  static int maxLevel = 30;

  // Calories burned per minute = (MET x body weight in Kg x 3.5) ÷ 200
  // Detail here: https://captaincalculator.com/health/calorie/calories-burned-jumping-rope-calculator/

  static double getJumpingMet(double jpm) {
    if (jpm == 0) return 0;
    if (jpm < 100) {
      return 8.8 * jpm / 100;
    } else if (jpm < 120) {
      return 11.8;
    } else {
      return 12.3;
    }
  }
}
