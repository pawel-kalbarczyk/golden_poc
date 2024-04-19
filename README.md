# golden_poc

A simple flutter project to demonstrate how golden tests can be created, when and how to write and use them and to show what are the limitations, restrictions and issues that devs might occur.

## Why do we want golden tests?

Goldens help us to:
- Avoid unpredicted changes to the UI components
- Quickly check if the screen/widget looks properly
- Find possible UI errors/issues (like overflows) faster 
- Document UI updates

## Possible solutions

There are 3 main solutions to write golden tests in flutter:
- using tools from flutter itself, without any additional package
- using [golden_toolkit](https://pub.dev/packages/golden_toolkit) 
- using [alchemist](https://pub.dev/packages/alchemist)

I would personally recommend using golden_toolkit. It provies API that's easy to use, with some additional useful utilities. The package is verified and reliable and from a verified developer.

Alchemist tries to make an alternative for golden_toolkit but in my opinion is a bit too complicated and doesn't really bring any important changes or improvements.

As for writing goldens using flutter without any additional packages, it's basically writing widget test with `matchesGoldenFile` function. It's good but more 'manual', without additional utilities that come with golden_toolkit.

This project focuses on showcasing and comparing differencess between flutter only solution and golden_toolkit.

## Configuration

To run golden tests, use `flutter test` just like in any other type of tests.

To generate/regenerate golden tests there is an additional flag:

 ```flutter test --update-goldens``` 

Or 

```flutter test --update-goldens --tags=golden```

To run only golden tests when regenerating, instead of every test in the project.

In VS Code it's possible to add a configuration to `launch.json` which will allow to run/regenerate goldens for specific file/group:

```
        {
            "name": "Golden",
            "request": "launch",
            "type": "dart",
            "codeLens": {
                "for": [
                    "run-test",
                    "run-test-file"
                ]
            },
            "args": [
                "--update-goldens"
            ]
        }
```

There is also posibility to add a config which allows to run some actions before running the actual test, for that create a file in test root folder called `flutter_test_config.dart` with contents like this:

```
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  return testMain();
}
```

This example allows to load fonts everytime automatically to avoid necessity to load them in every test.

## Writing tests - flutter only

Writing goldens without any packages requires to provide some additional configurations like screen sizes (see example in `/test/utils/screen_size_for_golden`). Other than that, it looks similar to writing widget tests, except developer needs to call for `matchesGoldenFile('file_path.png')` in `expectLater`.

Whenever there is a need to create several 'scenarios' like in golden_toolkit, developers have to wrap tested widgets/screens with some additional widgets that accept multiple children, like GridView.

Take a look at `/test/pages/home_page_test.dart - 'Golden Home Page - flutter'` for an example.

Take a look at `/test/pages/home_page_test.dart - 'Golden test - flutter'` for an example.

## Writing tests - golden_toolkit

There are 3 ways to write goldens with a toolkit:
- GoldenBuilder - allows to quickly test various states of a specific widget - usually used for single component, not the whole screen
- DeviceBuilder - allows to add configuration for single or multiple devices, usually used to test whole screens, all in one file
- multiScreenGolden() - provides an alternative and a simple way to generate multiple files for each of the declared devices (or default ones if nothing's declared)\

Take a look at `/test/pages/home_page_test.dart - 'Golden Home Page - golden_toolkit' group` for an example.

Take a look at `/test/widgets/tile_test.dart - 'Tile Widget golden_toolkit' group` for an example.

## What should be saved as a snapshot?

Team should choose to either:
 - test specific widgets (e.g. test only 'common' widgets used throughout the whole app to ensure there are no unpredicted and wrong changes, to detect any errors and to help ensure the widget is made well) - this can be achieved by using GoldenBuilder, take a look at `/test/widgets`
 - test whole screens (e.g. there might be no need to test smaller components if they're in the screens anyway, this also helps to ensure there are no errors, no unpredicted changes, and helps to verify the whole screen is made well) - this can be achieved by using DeviceBuilder, take a look at `/test/pages`
 - test both widgets and screens to provide the most complex way of ensuring the whole UI looks like it's supposed to and to avoid any mistakes when modifying it. Most time consuming, but most efficient

## Difficulties, issues and limitations

- Localization - This one is probably the most important. Flutter has some issues with rendering some items, mainly fonts (but rarely also things like imported assets etc.). This causes some languages to be rendered improperly and it's especially important if the app uses Arabic language. I couldn't find any way for the 'ar' locale to render fonts properly and the tests resulted in displaying glitched out boxes. Besides fonts, Locale is fully supported, meaning texts, even glitched, will be rendered right-to-left when declaring e.g. 'ar' Locale.
- Lack of documentation - This is an issue for all golden tests, no matter the package - there is little information and data about them and learning them can be a bit troublesome, especially when dealing with edge cases like the ones mentioned below
- Mocking data - Mocking data and especially stubbing it can become a bit troublesome depending on a use case. In theory it works just like in usual tests. In practice, in golden tests developers can encounter issues like e.g. only the first/last scenario being displayed properly with declared mocks, mocks not working at all resulting in red error screens etc. Nearly all of these issues can be fixed or worked around, but it could require to get a deeper knowledge of flutter or/and golden_toolkit library. 
- Multiple scenarios/device sizes - Developers will need to learn how the package behaves to avoid some errors. For example, when opening a drawer programatically for test with multiple screens, onCreate function will have to contain code that opens all rendered drawers. Simply opening one will result in first screen having it opened, and it will still be closed for the rest. Another example is displaying a Dialog when also testing other scenarios, take look at `/test/pages/goldens/homepage_dialog.png`.
- Unpredicted visual issues - Similarly to the previous point, developers can encounter some issues in golden test results that are not displayed in the app. For example, if we won't declare any size constraints for a widget, it can be much wider. 
- Doesn't support network images (can be worked around)

## Additional resources

- https://medium.com/@mregnauld/how-to-implement-your-design-system-in-a-flutter-app-2-2-c3327109d869 - scroll down to 'OK. What about tests?' section
- https://youtu.be/TT22JBKyhXw?si=ydQCVJ6B7Hn6Rg1A
- https://github.com/eBay/flutter_glove_box/tree/master/packages/golden_toolkit/test
- https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html
- https://medium.com/swlh/test-your-flutter-widgets-using-golden-files-b533ac0de469

## One more thing

Consider widgetbook for widget/screen base checking?
https://pub.dev/packages/widgetbook
