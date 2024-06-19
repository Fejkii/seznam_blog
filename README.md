# seznam_blog

[GitHub repository with project Seznam_blog](https://github.com/Fejkii/seznam_blog)

## Requirements

- Installed [Flutter framework](https://docs.flutter.dev/get-started/install) version 3.22 and newer

- Installed [Dart](https://dart.dev/get-dart) version 3.4 and newer

- Installed [VS Code](https://code.visualstudio.com/download)

- Installed Xcode / Android Studio / Web browser for run application

## Install application

1. Clone application

```
git clone https://github.com/Fejkii/seznam_blog
```

2. Move to app directory `seznam_blog`

```
cd seznam_blog
```

3. Install dependencies

```
flutter pub get
```

Nezapomeňte uvést všechny potřebné kroky (například v případě použití generování souborů).

## Start application

```
flutter run
```

## Libraries used

- [DIO](https://pub.dev/packages/dio)

  - http networking package

- [PrettyDioLogger](https://pub.dev/packages/pretty_dio_logger)

  - interceptor fo log network calls

- [Flutter_Bloc](https://pub.dev/packages/flutter_bloc)

  - state management
  - This package is used because it is my favorite, I have verified it for a long time and I have the most experience with it.

- [GetIt](https://pub.dev/packages/get_it)

  - depndency injection

- Internationalization and localization:

  - [flutter_localizations](https://pub.dev/packages/flutter_localization)

  - [intl](https://pub.dev/packages/intl)

- [Hive](https://pub.dev/packages/hive/install)

  - Local storage

- [Flutter Toast](https://pub.dev/packages/fluttertoast)

  - Toast messages (succes, error, warning)

## Supported platforms

Aplication is executable on mobile (Android and iOS) and web.

## Aplication architecture
- The layout and architecture of the application is relatively easy to expand. In the repository, I can simply change the data source (whether to get data from a remote server or a local database).

- You can also easily add new endpoints to the application to get data.

- As part of the user interface, I use reusable widgets here.

## Other possible functionalities

- Edit comments

- UI

- 
