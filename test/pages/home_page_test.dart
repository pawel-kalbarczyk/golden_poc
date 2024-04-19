import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_poc/pages/home_page.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../utils/load_page_for_golden.dart';
import '../utils/screen_size_for_golden.dart';

void main() {
  group('Golden Home Page - flutter', () {
    // Usual golden test without third party libraries and with a custom screen size
    testWidgets('Golden test', (WidgetTester tester) async {
      await tester.setScreenSize(width: 1920, height: 1080);
      await tester.pumpWidget(loadPageForGolden(page: const HomePage()));
      await expectLater(find.byType(HomePage), matchesGoldenFile('homepage_flutter.png'));
    });
    // the same test but with a code to open a drawer - not working
    testWidgets('Golden test - Drawer open', (WidgetTester tester) async {
      await tester.setScreenSize(width: 1920, height: 1080);
      await tester.pumpWidget(loadPageForGolden(page: const HomePage()));

      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openDrawer();
      await tester.pump();

      await expectLater(find.byType(HomePage), matchesGoldenFile('homepage_flutter_drawer_open.png'));
    });
  });

  group('Golden Home Page - golden_toolkit', () {
    // Showcase for multiple scenarios and multiple screens using DeviceBuilder
    testGoldens('HomePage main test', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          Device.iphone11,
          Device.tabletLandscape,
        ])
        ..addScenario(
          name: 'HomePage Open Drawer',
          // we can do some actions in onCreate just before golden test makes a screenshot
          onCreate: (_) async {
            // opening drawer for the first declared device
            final ScaffoldState state = tester.firstState(find.byType(Scaffold));
            state.openDrawer();
            // opening drawer for the second declared device
            final ScaffoldState state2 = tester.stateList(find.byType(Scaffold)).toList()[1] as ScaffoldState;
            state2.openDrawer();
            await tester.pump();
          },
          widget: loadPageForGolden(page: const HomePage()),
        )
        ..addScenario(
          name: 'HomePage Close Drawer',
          widget: loadPageForGolden(page: const HomePage()),
        )
        ..addScenario(
          name: 'HomePage Close Drawer AR',
          widget: loadPageForGolden(page: const HomePage(), rtl: true),
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'homepage_main');
    });

    // Showcase for multiple scenarios issue with displaying a dialog
    testGoldens('HomePage with dialog', (tester) async {
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(devices: [
          Device.iphone11,
          Device.tabletLandscape,
        ])
        ..addScenario(
          name: 'HomePage Open Drawer',
          onCreate: (_) async {
            final ScaffoldState state = tester.firstState(find.byType(Scaffold));
            state.openDrawer();
            await tester.pump();
          },
          widget: loadPageForGolden(page: const HomePage()),
        )
        ..addScenario(
          name: 'HomePage Close Drawer',
          widget: loadPageForGolden(page: const HomePage()),
        )
        ..addScenario(
          name: 'HomePage Show Dialog',
          onCreate: (_) async {
            await tester.tap(find.byKey(const ValueKey('button')).first);
            await tester.pumpAndSettle();
          },
          widget: loadPageForGolden(page: const HomePage()),
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'homepage_dialog');
    });

    // showcase on how to display dialog properly on multiple screens - using multiScreenGolden
    // instead of DeviceBuilder, resulting in few separate files with snapshots
    testGoldens('HomePage only dialog', (tester) async {
      await tester.pumpWidgetBuilder(
        loadPageForGolden(page: const HomePage()),
      );
      await tester.tap(find.byKey(const ValueKey('button')).first);

      await multiScreenGolden(tester, 'homepage_dialog_only', devices: [
        Device.iphone11,
        Device.tabletLandscape,
        const Device(
          name: 'full hd',
          size: Size(1920, 1080),
        ),
      ]);
    });
  });
}
