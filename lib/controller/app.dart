import 'package:edermanapp/core/dio.dart';
import 'package:edermanapp/core/log.dart';
import 'package:edermanapp/model/app/locale.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

enum AppConnectionStatus { loading, done, error }

class AppController extends GetxController {
  var token = Rx<String?>(null);

  var appStatus = Rx<AppConnectionStatus>(AppConnectionStatus.loading);
  var isDarkMode = Rx<bool>(false);

  @override
  void onInit() {
    initLocale();
    super.onInit();
  }

  @override
  void onReady() {
    initAppstatus();
    super.onReady();
  }

  Future<void> initAppstatus({bool onlySettings = false}) async {
    if (appStatus.value != AppConnectionStatus.loading && !onlySettings) {
      appStatus.value = AppConnectionStatus.loading;
      update();
    }

    var inDio = InDio();
    var dio = inDio.instance;
    try {
      var resp = await dio.get('/app/check');
      if (resp.data['status'] == true) {
        Log.success('Успешно подключено');
        appStatus.value = AppConnectionStatus.done;
      } else {
        Log.error('Ошибка подключения');
        appStatus.value = AppConnectionStatus.error;
      }
    } catch (_) {
      Log.error('Ошибка подключения $_');
      appStatus.value = AppConnectionStatus.error;
    }
    update();
  }

  static Future<void> loadAppData() async {
    // var catalog = Get.find<CatalogController>();
    // await catalog.fetchCategories();
    // catalog.fetchHome();
    // var articleController = Get.find<ArticlesController>();
    // articleController.fetchArticles();
    // articleController.fetchInformations();
    return;
  }

  static Map<String, String Function(Object)> validationMessages = {
    ValidationMessage.required: (error) => 'fill_field'.tr,
    ValidationMessage.email: (error) => 'wrong_format'.tr,
    ValidationMessage.mustMatch: (error) => 'not_match'.tr,
    ValidationMessage.minLength: (error) => 'min_length'.trParams({'n': '${(error as Map)['requiredLength']}'}),
    ValidationMessage.maxLength: (error) => 'max_length'.trParams({'n': '${(error as Map)['requiredLength']}'})
  };

  var locale = Rx<Locale>(const Locale('ru', 'RU'));

  static List<AppLocaleModel> supportedLocales = [
    AppLocaleModel(locale: const Locale('ru', 'RU'), title: 'Русский', id: 1),
    AppLocaleModel(locale: const Locale('en', 'US'), title: 'English', id: 2),
    AppLocaleModel(locale: const Locale('tk', 'TM'), title: 'Türkmen', id: 3),
  ];

  int get getLangIdByCurrentLocale {
    var currentLocale = locale.value;
    var matchedLocale = supportedLocales.firstWhere(
      (localeModel) => localeModel.locale.languageCode == currentLocale.languageCode,
      orElse: () => supportedLocales.first,
    );
    return matchedLocale.id;
  }

  Future<void> initLocale() async {
    var cachedLocale = prefs?.getString('locale');
    if (cachedLocale != null) {
      locale.value = Locale(cachedLocale);
      Get.updateLocale(locale.value);
      Log.success('Locale loaded from cache: $cachedLocale');
    }
  }

  void switchLocale(Locale newLocale) async {
    await prefs?.setString('locale', newLocale.languageCode);
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    // TODO Обнорвить данные в зависимых контроллерах
    // Get.find<CartController>().setLanguage();
    // Get.find<CatalogController>().fetchHome();
    // Get.find<ArticlesController>()
    //   ..fetchArticles()
    //   ..fetchInformations();
    // Get.find<EventController>().addStreamEvent(CoreEvents.localeChanged);
    Log.success('Locale switched to ${newLocale.languageCode}');
  }
}
