# StarMate

Flutter app for meeting new friends by zodiac sign: browse people, filter by zodiac sign and gender, and send friend requests.

**Status:** Course project (PRM392), FPT University, 2024 — archived. The backend is offline, so the app cannot sign in or load data.

## My role

Team Lead and mobile developer. In this repository I built:

- Friend list page and the friend list API calls.
- Friend requests and notifications in the home header.
- Person detail dialog on the home screen.
- Profile page, light/dark theme switch and logout.
- Password reset flow: OTP entry and new password.

The home feed with filters, sign-in, registration and profile editing were mainly built by [@giabao25](https://github.com/giabao25).

## Team

Commits in this repository: [@giabao25](https://github.com/giabao25) and [@Let-cal](https://github.com/Let-cal).

## Stack

Flutter (Dart SDK ^3.5.3), Provider, http, shared_preferences, google_fonts, animations, font_awesome_flutter.

## How to run

The repository contains `lib/` and `pubspec.yaml` only. Generate the platform folders first:

```sh
flutter create .
flutter pub get
flutter run
```

API URLs are hard-coded in `lib/services/api_service.dart` and point to the old Azure backend, which no longer exists.

## Known limitations

- The backend is offline, so the app stops at sign-in.
- No platform folders in the repository.
- No automated tests.
