import 'dart:developer' as developer;
import 'package:edermanapp/controller/other/log.dart';
import 'package:edermanapp/model/other/log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Log {
  static void info(String msg) {
    developer.log('\x1B[34m$msg\x1B[0m');
    var logger = Get.find<LogController>();
    logger.set(LogModel(text: msg, color: const Color.fromARGB(255, 63, 228, 250)));
  }

  static void success(String msg) {
    developer.log('\x1B[32m$msg\x1B[0m');
    var logger = Get.find<LogController>();
    logger.set(LogModel(text: msg, color: const Color.fromARGB(255, 40, 219, 34)));
  }

  static void warning(String msg) {
    developer.log('\x1B[33m$msg\x1B[0m');
    var logger = Get.find<LogController>();
    logger.set(LogModel(text: msg, color: const Color.fromARGB(255, 238, 255, 0)));
  }

  static void error(String msg) {
    developer.log('\x1B[31m$msg\x1B[0m');
    var logger = Get.find<LogController>();
    logger.set(LogModel(text: msg, color: const Color.fromARGB(255, 245, 78, 0)));
  }
}
