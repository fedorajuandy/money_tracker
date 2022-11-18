# PPB UAS

2019130032 - Fedora Yoshe Juandy

## Money Tracker

<a href="https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins">Add Firebase to Flutter</a>

### Firebase CLI setup

1. npm install -g firebase-tools
2. firebase login
3. dart pub global activate flutterfire_cli
4. Add the path to env
### Firebase app setup

1. I have already had Firebase account
2. Create new app in Firebase

<!-- ANDROID -->
3. Choose android after setup (the middle green... andorid icon)
4. Enter app package name from android/app/build.gradle (com.example.bla) + nickname
While there, change the minSdkVersion to 21 and target to 28
5. Download google-services.json in android/app
6. In android/build.gradle (NOTE: DIFF FROM BEFORE), add classpath in dependencies
7. In build.gradle (app), add apply together with the rest (change into the same format)
[THE REST LATER IN yaml]
8. flutter-packages-get

<!-- iOS -->
9. Choose iOS (most left)
10. Enter name from ios/Runner.xcodeproj/project.pbxproj (PRODUCT_BUNDLE_IDENTIFIER)
11. Download plist to ios/Runner
12. add:
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
    to main.dart main and correct mistake with the bulb
13. change home to (more or less):
    FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error:  ${snapshot.error.toString()}");
          } else if (snapshot.hasData) {
            return const MyHomePage(title: "LOL");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

### Firebase project setup

1. flutterfire configure
2. flutter pub add firebase_core [CAN ADD MANUALY TO yaml IF YA WANNA <a href="https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins">Firebase plugins</a>]
3. flutter pub add firebase_database
4. flutterfire configure
5. In main.dart add
    import 'package:firebase_core/firebase_core.dart';
    import 'firebase_options.dart';
6. add:
    final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
    to MyApp and change the app not to const
7. flutterfire configure

## Codes references

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

## Design references

- <a href="https://uxdesign.cc/3-colors-for-financial-applications-ec75c806e454">Finance app colors</a>
- <a href="https://dribbble.com/tags/expense_tracker">UI/UX</a>
- <a href="https://www.behance.net/gallery/79266823/Budget-tracker-App-UI-kit">Main UI/UX</a>

> Green for choices, quantity, quality, and growth

- <a href="https://www.crazyegg.com/blog/color-palettes-financial/">Finance app color palletes</a>
## Images references

- Brand logos are made using <a href="https://express.adobe.com/express-apps/logo-maker">Adobe Express</a> and edited using <a href="https://www.figma.com/">Figma</a>
- 
