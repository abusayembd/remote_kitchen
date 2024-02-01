import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remote_kitchen/presentation/home/bindings/home_binding.dart';

import 'infrastructure/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Remote Kitchen",
      initialRoute: AppPages.initial,
      initialBinding: HomeBinding(),
      getPages: AppPages.routes,
    ),
  );
}
