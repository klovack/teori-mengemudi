# Teori Mengemudi

A flutter application to teach Driving Theory in Indonesia.

This project is ongoing, so expect many bugs when using it.

## Development

1. Clone the repo
2. Install dependencies by doing
  ```
  flutter pub get
  ```
3. Open iOS Simulator or android Emulator (optional)
4. Run the application by doing
  ```
  flutter run
  ```


## API KEYS

This project uses several API Keys, and these keys are not included in git for obvious reason.

Below are the list of keys that are used in this project:

```sh
# Google Admob APP ID
GOOGLE_ADMOB_APP_ID=ca-app-pub-xxxxxxxxxxxxxx~xxxxxxxxx
```

### How to set the API Keys

Copy the list of API Keys above and create the files for each target build as follow:

- **Android**: `android/apikey.properties`
- **ios**: `ios/Flutter/.env`

## Build

### Android

To build production app bundle for android, execute:

```
flutter build appbundle --flavor=prod
```
