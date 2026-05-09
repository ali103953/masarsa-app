# MASARSA Production Checklist

## Codemagic

- Add the `apple` environment group.
- Add `APP_STORE_CONNECT_PRIVATE_KEY`.
- Add `APP_STORE_CONNECT_KEY_IDENTIFIER`.
- Add `APP_STORE_CONNECT_ISSUER_ID`.
- Set `APP_STORE_APPLE_ID` in `codemagic.yaml` after creating the App Store Connect app record.
- Confirm bundle ID `online.masarsa.app` exists in Apple Developer Portal.
- Confirm automatic signing can create or find an App Store provisioning profile.

## App Store Connect

- Create the MASARSA app record.
- Add Arabic and English app name metadata.
- Add privacy policy URL.
- Add support URL.
- Add school transportation category metadata.
- Add screenshots for required iPhone and iPad sizes.
- Complete age rating and data safety answers.

## Firebase

- Keep Firebase owned by the hosted web app while this repository remains a WebView shell.
- Add `GoogleService-Info.plist` only when native Firebase SDKs are added to Flutter.
- Add native Crashlytics and Analytics only after consent, privacy policy, and Firebase project settings are confirmed.

## Native Features To Add Next

- Push notifications for bus arrival, pickup, drop-off, and route delay.
- Role-aware deep links for parent, driver, and school dashboards.
- Driver foreground/background location tracking with clear consent.
- Offline fallback for today route, student list, and emergency contacts.
- In-app incident reporting for driver and school staff.
- Parent pickup authorization and QR/code-based student handoff.
- Audit logs for school administrators.
- Arabic accessibility labels and larger-text QA.

## Release Verification

- Run `flutter pub get`.
- Run `flutter analyze`.
- Run `flutter test`.
- Run Codemagic `ios-testflight`.
- Install the TestFlight build on a real iPhone.
- Verify login, dashboard routing, map loading, Arabic layout, and offline error state.
