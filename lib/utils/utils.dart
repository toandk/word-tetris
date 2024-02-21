import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tetris/base/networking/base/app_exception.dart';
import 'package:tetris/generated/locales.g.dart';
import 'package:tetris/routes/routes.dart';
import 'package:tetris/utils/analytics.dart';
import 'package:tetris/utils/popup.dart';
import 'package:tetris/utils/text_element.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tetris/widgets/alert_dialog.dart';
import 'package:path_provider/path_provider.dart';

import 'log.dart';

const String _languageKey = "language_key";
const String _soundKey = "sound_key";

class Utils {
  Utils._();

  static final player = AudioPlayer();

  static void logOut() {}

  static void vibrateDevice() async {}

  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = "";
    try {
      if (GetPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? "";
      } else if (GetPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.serialNumber;
      } else if (GetPlatform.isLinux) {
        var info = await deviceInfo.linuxInfo;
        deviceId = info.machineId ?? "";
      }
    } on PlatformException {
      logDebug('Failed to get platform version');
    }
    if (deviceId == "") {
      return "ABC";
    }
    return deviceId;
  }

  static bool isValidUrl(String? url) {
    url ??= "";
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  static String pluralizeMany(String string, num number) {
    int count = number.round();
    if (count == 0) {
      return "${string}_zero".tr.replaceFirst("%", count.toString());
    } else if (count == 1) {
      return "${string}_one".tr.replaceFirst("%", count.toString());
    }
    return "${string}_many".tr.replaceFirst("%", count.toString());
  }

  static double getBottomSheetPadding() {
    // check if the user's device has a navigator button bar or not
    return Get.window.viewPadding.bottom > 0 ? 0 : 0;
  }

  static Future<bool> get isBelowIOS14 async {
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var first = ParserHelper.parseInt(iosInfo.systemVersion.split('.').first);
      if (first is int) {
        return first < 14;
      }
    }
    return false;
  }

  static void back({dynamic result, bool closeOverlays = false}) {
    if (Get.routing.route?.isFirst == true) {
      SystemNavigator.pop(animated: true);
    } else {
      Get.back(result: result, closeOverlays: closeOverlays);
    }
  }

  static void handleError(Object error) {
    logDebug("got error ${error.toString()}");
    // isLoading.value = false;
    var message = 'Có lỗi xảy ra, vui lòng thử lại!';
    if (error is AppException) {
      message = error.toString();
    }
    Popup.instance.showSnackBar(message: message, type: SnackbarType.error);
  }

  static void dismissKeyboard() {
    // FocusScope.of(Get.context!).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static bool isSmallDevice() {
    return !isTablet() &&
        max(Get.height / Get.width, Get.width / Get.height) < 670 / 375;
  }

  static String dateTimeString(
      {required int millisecondsSinceEpoch, String format = 'dd/MM/yyyy'}) {
    return '';
  }

  static String addSIfNeeded(int measurement) {
    if (Get.locale?.languageCode == 'en') {
      if (measurement > 1) {
        return 's';
      }
    }
    return '';
  }

  static String _toString(int num) {
    if (num < 10) return "0$num";
    return num.toString();
  }

  static String toTimerString(int time) {
    int hour = (time / 3600).truncate();
    int minute = ((time - (hour * 60 * 60)) / 60).truncate();
    int seconds = (time - hour * 60 * 60 - minute * 60);
    String str =
        "${_toString(hour)}:${_toString(minute)}:${_toString(seconds)}";
    return str;
  }

  static void showDialog(
      {String title = "",
      String message = "",
      String? cancelText,
      String? confirmText,
      void Function()? onCancel,
      void Function()? onConfirm}) {
    void _onCancel() {
      Get.back();
      onCancel != null ? onCancel() : () => {};
    }

    void _onConfirm() {
      Get.back();
      onConfirm != null ? onConfirm() : () => {};
    }

    Get.dialog(MJDialog(
        title: title,
        content: message,
        cancelTitle: cancelText,
        confirmTitle: confirmText,
        onCancel: _onCancel,
        onConfirm: _onConfirm));
  }

  static void trackScreen(String name) {
    // FirebaseCrashlytics.instance.log('view screen ' + name);
  }

  static bool isTablet() {
    return min(Get.width, Get.height) >= 600;
  }
}

class ParserHelper {
  static int? parseInt(dynamic input) {
    if (input != null) {
      if (input is int) {
        return input;
      }
      if (input is double) {
        return input.toInt();
      }
      if (input is String) {
        return int.tryParse(input);
      }
    }
    return null;
  }

  static double? parseDouble(dynamic input) {
    if (input != null) {
      if (input is int) {
        return input.toDouble();
      }
      if (input is double) {
        return input;
      }
      if (input is String) {
        return double.tryParse(input);
      }
    }
    return null;
  }
}

extension DoubleUtil on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * Get.height / 100;

  double get h375 => this * min(Get.width, 700) / 375;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => this * Get.width / 100;

  double get w375 => this * min(Get.width, 700) / 375;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => this * (min(Get.width, 700) / 375);

  String amountText({int fixed = 6}) {
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    String number = toStringAsFixed(fixed).replaceAll(regex, '');
    return number;
  }
}
