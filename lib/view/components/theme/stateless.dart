import 'package:edermanapp/controller/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ThemedStatelessWidget extends StatelessWidget {
  const ThemedStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (controller) {
        return buildWithTheme(context, controller.isDarkMode.value);
      },
    );
  }

  Widget buildWithTheme(BuildContext context, bool isDarkMode);
}
