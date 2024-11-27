import 'package:edermanapp/controller/app.dart';
import 'package:edermanapp/controller/other/log.dart';
import 'package:edermanapp/controller/user.dart';
import 'package:edermanapp/core/colors.dart';
import 'package:edermanapp/translation/translation.dart';
import 'package:edermanapp/view/screen/util/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:navi/navi.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  prefs = await SharedPreferences.getInstance();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _informationParser = NaviInformationParser();
  final _routerDelegate = NaviRouterDelegate.material(
    child: const AppStartScreen(),
  );

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: AppController.validationMessages,
      child: GetMaterialApp.router(
        debugShowCheckedModeBanner: false,
        // return GetMaterialApp(
        title: 'Flutter sample',
        translations: CoreTranslations(),
        locale: const Locale('ru', 'RU'),
        supportedLocales: const [Locale('ru')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: CoreColors.primary),
        ),
        initialBinding: BindingsBuilder(() {
          Get.put(LogController(), permanent: true);
          Get.put(AppController(), permanent: true);
          Get.put(UserController(), permanent: true);
        }),
        // home: const TabsStartScreen(),
        routeInformationParser: _informationParser,
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
