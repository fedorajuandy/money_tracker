# PPB UAS - Money Tracker

2019130032 - Fedora Yoshe Juandy

`NOTE! Ignore master branch`

Long story short:

- committed at LIKMI
- tried to sync at LIKMI
- WiFi error
- everything got messed up
- my fever-addled brain decided just to move the branch
- present time:

## Notes

1. Cannot get parent key id[^2]

Firebase realtime database cannot get parent id from its child.

2. Cannot getChildren at snapshot[^3]

Apparently, it has already been an issue for quite awhile without further information. While the android version has it, the Flutter library does not. The suggested method is to use another cloud function, which I do not know what even it is in Flutter term.



## Firebase Realtime Database Setup[^1]

### Firebase CLI setup

1. `npm install -g firebase-tools`
2. firebase login
3. `dart pub global activate flutterfire_cli`
4. Add the path to env

### Firebase app setup

1. Make Firebase account
2. Create new app in Firebase

For Android:

3. Choose android after setup (the middle green... andorid icon)
4. Enter app package name from android/app/build.gradle (com.example.bla) + nickname
While there, change the minSdkVersion to 21 and target to 28
5. Download google-services.json in android/app
6. In android/build.gradle (NOTE: DIFF FROM BEFORE), add classpath in dependencies
7. In build.gradle (app), add apply together with the rest (change into the same format)
[THE REST LATER IN yaml]
8. flutter-packages-get

For iOS:

9. Choose iOS (most left)
10. Enter name from ios/Runner.xcodeproj/project.pbxproj (PRODUCT_BUNDLE_IDENTIFIER)
11. Download plist to ios/Runner

### Firebase project setup

1. `flutterfire configure`
2. `flutter pub add firebase_core` [CAN ADD MANUALY TO yaml IF YA WANNA <a href="https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins">Firebase plugins</a>]
3. `flutter pub add firebase_database`
4. `flutterfire configure`
5. In main.dart add
    `import 'package:firebase_core/firebase_core.dart';`
    `import 'firebase_options.dart';`
6. add:
    `final Future<FirebaseApp> _fbApp = Firebase.initializeApp();`
    to MyApp and change the app not to const
7. `flutterfire configure`

## Code references

- PPB class notes and past projects
- <a href="https://docs.flutter.dev/">Flutter documentation</a>
- <a href="https://flutterawesome.com/budget-tracker-app-ui-with-flutter/">UI/UX</a> from <a href="https://flutterawesome.com/">Flutter libraries and tools</a>
- <a href="https://stackoverflow.com/questions/71690214/how-do-construct-a-horizontally-scrollable-calendar-in-my-appbar-with-flutter">Horisontal scrolling calendar</a>
- <a href="https://pub.dev/packages/table_calendar">Table calendar</a>
- <a href="https://codingzest.com/firebase-realtime-database-crud-operations-for-flutter-project/">DateTime</a>
- <a href="https://codingzest.com/firebase-realtime-database-crud-operations-for-flutter-project/">Firebase realtime database CRUD</a>
- <a href="https://stackoverflow.com/questions/51420559/get-last-month-date-in-flutter-dart">Datetime</a>
- <a href="https://stackoverflow.com/questions/62022135/how-to-only-display-the-year-in-datepicker-for-flutter">YearPicker</a>
<a href="https://www.flutterbeads.com/change-date-picker-color-in-flutter/">Modify DatePicker</a>
- <a href="https://www.youtube.com/watch?v=3wsIBoyKmdA">TimePicker</a>
- <a href="https://stackoverflow.com/questions/14865568/currency-format-in-dart">Currency format</a>
- <a href="https://galangaji.medium.com/5-flutter-tutorial-cara-mudah-format-rupiah-pada-dart-c1711621e648">IDR format</a>
- <a href="https://stackoverflow.com/questions/54027270/how-to-create-a-scroll-view-with-fixed-footer-with-flutter">Fixed header footer</a>
- <a href="https://www.youtube.com/watch?v=eMHbgIgJyUQ">Icons</a>
- [For future builds](https://stackoverflow.com/questions/66100385/flutter-setstate-or-markneedsbuild-called-during-build-using-future-builde)
- [Difference between two dates](https://stackoverflow.com/questions/52713115/flutter-find-the-number-of-days-between-two-dates/67679455#67679455)
- [Modified alert dialog](https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095)
- [FlatButton alternative](https://stackoverflow.com/questions/66805535/flutter-flatbutton-is-deprecated-alternative-solution-with-width-and-height)
- [String to TimeOfDay](https://stackoverflow.com/questions/53382971/how-to-convert-string-to-timeofday-in-flutter)

## Design references

- <a href="https://uxdesign.cc/3-colors-for-financial-applications-ec75c806e454">Finance app colors</a>
- <a href="https://dribbble.com/tags/expense_tracker">General UI/UX</a>
- <a href="https://www.behance.net/gallery/79266823/Budget-tracker-App-UI-kit">Main UI/UX</a>
- <a href="https://www.crazyegg.com/blog/color-palettes-financial/">Finance app color palletes</a>

> Green for choices, quantity, quality, and growth. And money, of course.

## Image references

- Icon is made using <a href="https://express.adobe.com/express-apps/logo-maker">Adobe Express</a> and edited using <a href="https://www.figma.com/">Figma</a>

### Other references

[^1]: [How to Add Firebase to Flutter](https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins)
[^2]: [How to find parent key using child key in firebase realtime-database?](https://stackoverflow.com/questions/65725337/how-to-find-parent-key-using-child-key-in-firebase-realtime-database)
[^3]: [[firebase_database] Get children count without downloading all the children #1069](https://github.com/firebase/flutterfire/issues/1069)
