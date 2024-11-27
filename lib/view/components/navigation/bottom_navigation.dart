import 'package:edermanapp/core/colors.dart';
import 'package:edermanapp/routes/tabs.dart';
import 'package:edermanapp/view/components/theme/stateless.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarWidget extends ThemedStatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationBarWidget({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget buildWithTheme(BuildContext context, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: isDarkMode ? CoreColorsDark.backgroundOne : CoreColors.backgroundOne,
          ),
        ),
      ),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            enableFeedback: false,
            backgroundColor: isDarkMode ? CoreColorsDark.backgroundTwo : CoreColors.backgroundTwo,
            type: BottomNavigationBarType.fixed,
            elevation: 1,
            selectedItemColor: CoreColors.primary,
            unselectedItemColor: CoreColors.black,
            selectedFontSize: 12,
            unselectedLabelStyle: const TextStyle(height: 2),
            selectedIconTheme: const IconThemeData(
              color: CoreColors.primary,
            ),
            currentIndex: currentIndex,
            onTap: onTap,
            items: [
              for (var i = 0; i < tabData.length; i++)
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // TODO Обработать табы с бэджиком
                      // if (tabData[i].badge)
                      //   GetBuilder<CartController>(builder: (cart) {
                      //     var count = cart.cart.value?.products?.length;
                      //     return Badge(
                      //       isLabelVisible: count != null && count > 0,
                      //       label: Text('$count'),
                      //       offset: const Offset(8, -4),
                      //       child: Image.asset(
                      //         tabData[i].icon!,
                      //         // size: 24,
                      //         width: 24,
                      //         color: currentIndex == i ? CoreColors.primary : CoreColors.grey,
                      //       ),
                      //     );
                      //   })
                      // else
                      Icon(
                        tabData[i].icon!,
                        size: 24,
                        color: currentIndex == i
                            ? isDarkMode
                                ? CoreColorsDark.primary
                                : CoreColors.primary
                            : isDarkMode
                                ? CoreColorsDark.textDefault
                                : CoreColors.textDefault,
                      ),
                      Text(
                        tabData[i].label.tr,
                        style: TextStyle(
                            color: currentIndex == i
                                ? isDarkMode
                                    ? CoreColorsDark.primary
                                    : CoreColors.primary
                                : isDarkMode
                                    ? CoreColorsDark.textDefault
                                    : CoreColors.textDefault),
                      )
                    ],
                  ),
                  label: tabData[i].label.tr,
                )
            ]),
      ),
    );
  }
}
