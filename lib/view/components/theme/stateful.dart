import 'package:edermanapp/controller/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ThemedStatefulWidget extends StatefulWidget {
  const ThemedStatefulWidget({super.key});

  @override
  ThemedState createState();
}

abstract class ThemedState<T extends ThemedStatefulWidget> extends State<T> {
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
