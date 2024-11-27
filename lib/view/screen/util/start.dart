import 'package:edermanapp/controller/app.dart';
import 'package:edermanapp/controller/user.dart';
import 'package:edermanapp/core/animations.dart';
import 'package:edermanapp/core/colors.dart';
import 'package:edermanapp/routes/tabs.dart';
import 'package:edermanapp/view/components/navigation/bottom_navigation.dart';
import 'package:edermanapp/view/screen/auth/code.dart';
import 'package:edermanapp/view/screen/auth/login.dart';
import 'package:edermanapp/view/screen/auth/register.dart';
import 'package:edermanapp/view/screen/util/error.dart';
import 'package:edermanapp/view/screen/util/splash.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:navi/navi.dart';

// Transalted ✅

class AppStartScreen extends StatefulWidget {
  const AppStartScreen({super.key});

  @override
  State<AppStartScreen> createState() => _AppStartScreenState();
}

class _AppStartScreenState extends State<AppStartScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h,
      color: CoreColors.backgroundOne,
      child: GetBuilder<AppController>(
        builder: (controller) {
          Widget screen = const UtilSplashScreen();
          switch (controller.appStatus.value) {
            case AppConnectionStatus.done:
              screen = const AuthStartScreen();
              break;
            case AppConnectionStatus.loading:
              screen = const UtilSplashScreen();
              break;
            case AppConnectionStatus.error:
              screen = const UtilErrorScreen();
              break;
          }
          return AnimatedSwitcher(
            duration: CoreAnimations.defaultAnimationDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                  // return SlideTransition(
                  // position: Tween<Offset>(
                  //         begin: const Offset(1, 0), end: const Offset(0, 0))
                  //     .animate(animation),
                  opacity: animation,
                  child: child);
            },
            child: screen,
          );
        },
      ),
    );
  }
}

class AuthStartScreen extends StatefulWidget {
  const AuthStartScreen({super.key});

  @override
  State<AuthStartScreen> createState() => _AuthStartScreenState();
}

class _AuthStartScreenState extends State<AuthStartScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        // TODO Поставить правильное условие пользователя
        if (controller.user.value != null || controller.userStage.value == UserLoginStage.anon) {
          return const TabsStartScreen();
        } else {
          Widget screen = const AuthLoginScreen();
          switch (controller.userStage.value) {
            case UserLoginStage.login:
              screen = const AuthLoginScreen();
              break;
            case UserLoginStage.register:
              screen = const AuthRegisterScreen();
              break;
            case UserLoginStage.code:
              screen = const AuthCodeScreen();
              break;
            default:
          }
          return AnimatedSwitcher(
            duration: CoreAnimations.defaultAnimationDuration,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                  // return SlideTransition(
                  //     position: Tween<Offset>(
                  //             begin: const Offset(1, 0), end: const Offset(0, 0))
                  //         .animate(animation),
                  opacity: animation,
                  child: child);
            },
            child: screen,
          );
        }
      },
    );
  }
}

class TabsStartScreen extends StatefulWidget {
  const TabsStartScreen({super.key});

  @override
  State<TabsStartScreen> createState() => _TabsStartScreenState();
}

class _TabsStartScreenState extends State<TabsStartScreen> {
  @override
  void initState() {
    AppController.loadAppData();
    super.initState();
  }

  var pageController = PageController();

  var currentIndex = ValueNotifier<int>(0);
  void onTap(int index) {
    if (currentIndex.value == index) {
      if (tabData[index].navigatorKey.currentState?.canPop() ?? false) {
        tabData[index].navigatorKey.currentState?.popUntil((route) => route.isFirst);
      }
    } else {
      currentIndex.value = index;
      pageController.jumpToPage(index);
    }

    // pageController.animateToPage(index,
    //     duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        var pop = false;
        var currentState = tabData[currentIndex.value].navigatorKey.currentState;
        if (currentState?.canPop() ?? false) {
          currentState?.pop();
          pop = false;
        }
        if (pop) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: tabData.mapIndexed((i, e) => TabBridge(active: i == currentIndex.value, tab: e)).toList(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          child: ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (_, c, __) {
                return Container(
                    decoration: const BoxDecoration(),
                    child: BottomNavigationBarWidget(
                      currentIndex: c,
                      onTap: onTap,
                    ));
              }),
        ),
      ),
    );
  }
}

class TabBridge extends StatefulWidget {
  const TabBridge({Key? key, required this.active, required this.tab}) : super(key: key);
  final bool active;
  final TabDataModel tab;

  @override
  State<TabBridge> createState() => TabBridgeState();
}

class TabBridgeState extends State<TabBridge> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NaviStack(
        navigatorKey: widget.tab.navigatorKey,
        active: widget.active,
        pages: (context) => [NaviPage.material(key: ValueKey(widget.tab.navigatorKey), child: widget.tab.screen)]);
  }
}
