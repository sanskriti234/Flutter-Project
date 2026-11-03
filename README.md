# BIET Lucknow – Student College Website (Flutter Web)

A four-page responsive college website (Home, About Us, Courses, Contact Us) built with Flutter, Dart and Material Design 3.

> **Disclaimer:** This is a student-created academic project inspired by the official BIET website (https://www.bansaliet.in/). It is **not** the official website of Bansal Institute of Engineering & Technology and is not endorsed by the institute. The contact form is a frontend demo – messages are not sent anywhere.

## Folder structure

```
biet_website/
├── pubspec.yaml
├── assets/
│   └── images/            <- put your images here (see README.txt inside)
└── lib/
    ├── main.dart
    ├── theme/
    │   └── app_theme.dart
    ├── pages/
    │   ├── home_page.dart
    │   ├── about_page.dart
    │   ├── courses_page.dart
    │   └── contact_page.dart
    └── widgets/
        ├── navbar.dart
        ├── footer.dart
        ├── course_card.dart
        ├── info_card.dart
        ├── common.dart        (shared helpers: sections, grid, images)
        └── page_layout.dart   (navbar + scroll body + footer frame)
```

## Run

```bash
flutter create biet_website      # creates platform folders (web/, android/ ...)
cd biet_website
# copy lib/, assets/ and pubspec.yaml from this project into it (overwrite)
# delete test/widget_test.dart and analysis_options.yaml
flutter pub get
flutter run -d chrome
```
