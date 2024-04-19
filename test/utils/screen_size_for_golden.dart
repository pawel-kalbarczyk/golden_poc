import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension SetScreenSize on WidgetTester {
  Future<void> setScreenSize({
    double width = 540,
    double height = 960,
    double pixelDensity = 1,
  }) async {
    final size = Size(width, height);
    await binding.setSurfaceSize(size);
    view.devicePixelRatio = pixelDensity;
    view.physicalSize = size;
  }
}
