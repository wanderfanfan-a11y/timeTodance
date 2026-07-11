import 'package:flutter/material.dart';

// 中文字形由 Flutter/Skia 的系统字体回退机制自动选用（如 Microsoft YaHei UI），
// 无需在此显式指定 fontFamily —— 若指定了未随应用打包的字体名称，
// 该设置会被静默忽略，反而不如交给自动回退可靠。
ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3D5AFE), brightness: Brightness.light),
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3D5AFE), brightness: Brightness.dark),
  );
}
