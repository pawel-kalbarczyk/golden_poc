import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_poc/core/gen/l10n.dart';
import 'package:golden_poc/widgets/tile.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../utils/load_page_for_golden.dart';

void main() {
  // showcase for testing few states of one widget only with flutter
  testWidgets('Golden test - flutter', (WidgetTester tester) async {
    await tester.pumpWidget(
      loadPageForGolden(
        page: const Scaffold(
          body: Column(
            children: [
              TileWidget(
                showError: false,
              ),
              TileWidget(
                showError: true,
              ),
            ],
          ),
        ),
      ),
    );
    await expectLater(find.byType(Scaffold), matchesGoldenFile('goldens/tile_widget_flutter.png'));
  });

  // showcase for testing few states of one widget with golden_toolkit - using pl locale works
  group('Tile Widget golden_toolkit', () {
    testGoldens('Tile Widget', (tester) async {
      final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
        ..addScenario(
            'Success',
            const TileWidget(
              showError: false,
            ))
        ..addScenario(
            'Error',
            const TileWidget(
              showError: true,
            ));

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(
          localizations: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeOverrides: [const Locale('en')],
        ),
      );

      await screenMatchesGolden(tester, 'tile_types_grid_pl');
    });

    // Showcase of 'directionality' being changed properly for 'ar' Locale, but without proper font rendering
    testGoldens('Tile Widget AR', (tester) async {
      final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
        ..addScenario(
            'Success',
            const TileWidget(
              showError: false,
            ))
        ..addScenario(
            'Error',
            const TileWidget(
              showError: true,
            ));

      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(
          localizations: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeOverrides: [const Locale('ar')],
        ),
      );

      await screenMatchesGolden(tester, 'tile_types_grid_ar');
    });
  });
}
