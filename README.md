# PPB UAS - Money Tracker

2019130032 - Fedora Yoshe Juandy

`NOTE! Ignore master branch`

Long story short:

- committed at campus using Wi-Fi
- tried to sync at campus using said Wi-Fi
- Wi-Fi error
- everything got messed up
- my fever-addled brain decided just to move the branch
- present time:

## Notes

1. Cannot get parent key id[^1]

> Firebase realtime database cannot get parent id from its child. For plan's operations, every operation has a parentKey for reference.

2. Cannot getChildren at snapshot[^2]

> For FirebaseAnimatedList, there is supposed to be a method getChildren() in android; unfortunately there is no such thing in Flutter and has already been an issue for quite awhile. So the 'Report' part of application cannot simply just itterate the whole thing and return the very last one.

## Firebase Realtime Database Setup[^3]

### CLI setup

1. `npm install -g firebase-tools`
2. Firebase login
3. `dart pub global activate flutterfire_cli`
4. Add the path to env

### App setup

1. Make Firebase account
2. Create new app in Firebase

For Android:

3. Choose Android after setup (the middle green Android icon)
4. Enter app package name from android/app/build.gradle (com.example.something) + nickname. While there, change the minSdkVersion to 21 and target to 28
5. Download google-services.json to android/app
6. In android/build.gradle (NOTE: DIFF FROM BEFORE), add classpath in dependencies
7. In build.gradle (android/app/build.gradle), add apply together with the rest (change into the same format) [THE REST LATER IN yaml]
8. `flutter-packages-get`

For iOS:

9. Choose iOS (most left one)
10. Enter name from ios/Runner.xcodeproj/project.pbxproj (PRODUCT_BUNDLE_IDENTIFIER)
11. Download plist to ios/Runner

### Project setup

1. `flutterfire configure`
2. `flutter pub add firebase_core` [CAN ADD MANUALY TO yaml by [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins)
3. `flutter pub add firebase_database`
4. `flutterfire configure`
5. In main.dart add `import 'package:firebase_core/firebase_core.dart';` and `import 'firebase_options.dart';`
6. add `final Future<FirebaseApp> _fbApp = Firebase.initializeApp();` to MyApp and change the app not to const
7. `flutterfire configure`

## References

### Codes

- PPB class notes and past projects
- [Flutter documentation](https://docs.flutter.dev/)
- [For main layout UI](https://flutterawesome.com/budget-tracker-app-ui-with-flutter/)
- [For horisontal scrolling calendar](https://stackoverflow.com/questions/71690214/how-do-construct-a-horizontally-scrollable-calendar-in-my-appbar-with-flutter)
- [table_calendar 3.0.8 ](https://pub.dev/packages/table_calendar)
- [For basic Realtime Database CRUD](https://codingzest.com/firebase-realtime-database-crud-operations-for-flutter-project/)
- [For getting last month; for horisontal scrolling calendar](https://stackoverflow.com/questions/51420559/get-last-month-date-in-flutter-dart)
- [For YearPicker widget](https://stackoverflow.com/questions/51420559/get-last-month-date-in-flutter-dart)
- [For changing DatePicker colors](https://www.flutterbeads.com/change-date-picker-color-in-flutter/)
- [For TimePicker widget](https://www.youtube.com/watch?v=3wsIBoyKmdA)
- [For rupiah currency formatting](https://galangaji.medium.com/5-flutter-tutorial-cara-mudah-format-rupiah-pada-dart-c1711621e648)
- [For scroll view with some parts fixed](https://stackoverflow.com/questions/54027270/how-to-create-a-scroll-view-with-fixed-footer-with-flutter)
- [How to change app icon](https://stackoverflow.com/questions/53967670/flutter-launcher-icon-not-getting-changed); [cannot use SVG format](https://stackoverflow.com/questions/68243711/is-there-any-way-to-use-svg-as-app-icon-in-flutter)
- [For future builds](https://stackoverflow.com/questions/66100385/flutter-setstate-or-markneedsbuild-called-during-build-using-future-builde)
- [For difference between two dates](https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates/67679455#67679455)
- [For modified alert dialog](https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095)
- [For FlatButton widget alternative](https://stackoverflow.com/questions/66805535/flutter-flatbutton-is-deprecated-alternative-solution-with-width-and-height)
- [For converting String to TimeOfDay](https://stackoverflow.com/questions/53382971/how-to-convert-string-to-timeofday-in-flutter)
- [For decimals precise places](https://stackoverflow.com/questions/28419255/how-do-you-round-a-double-in-dart-to-a-given-degree-of-precision-after-the-decim)

### Designs

- [General UI/UX for expense trackers](https://dribbble.com/tags/expense_tracker)
- [Main UI/UX layout for this money tracker](https://www.behance.net/gallery/79266823/Budget-tracker-App-UI-kit)
- [Finance app colors](https://uxdesign.cc/3-colors-for-financial-applications-ec75c806e454)
- [Finance app color palletes](https://www.crazyegg.com/blog/color-palettes-financial/)

> Green for choices, quantity, quality, and growth. Also money, of course.

### Images

- Icon is made by <a href="https://express.adobe.com/express-apps/logo-maker">Adobe Express</a> and edited by <a href="https://www.figma.com/">Figma</a>

[^1]: [How to find parent key using child key in firebase realtime-database?](https://stackoverflow.com/questions/65725337/how-to-find-parent-key-using-child-key-in-firebase-realtime-database)
[^2]: [[firebase_database] Get children count without downloading all the children #1069](https://github.com/firebase/flutterfire/issues/1069)
[^3]: [How to Add Firebase to Flutter](https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins)
