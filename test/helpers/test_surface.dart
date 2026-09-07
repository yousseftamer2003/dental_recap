import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Default test window is 800x600; auth forms are taller than that.
void useTallPhone(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}
