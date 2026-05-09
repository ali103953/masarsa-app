# MASARSA

MASARSA is an Arabic-first school transportation application shell for iOS. The Flutter app loads the production MASARSA web experience at:

https://masarsa.online/

## App Identity

- App name: MASARSA / مسارسا
- Bundle ID: `online.masarsa.app`
- Release version: `1.0.0+1`
- Production iOS build path: Flutter + Codemagic

## Current Architecture

This repository is currently a Flutter WebView wrapper around the hosted MASARSA product. The native shell is responsible for:

- iOS packaging and signing
- TestFlight delivery
- Arabic loading and error states
- safe WebView host restrictions
- iOS permission descriptions required by App Store review

The hosted MASARSA web app should own the parent, driver, school, Firebase, dashboard, and tracking business logic until those features are migrated into native Flutter modules.

## Codemagic Setup

Codemagic requires these secrets in the `apple` environment group:

- `APP_STORE_CONNECT_PRIVATE_KEY`
- `APP_STORE_CONNECT_KEY_IDENTIFIER`
- `APP_STORE_CONNECT_ISSUER_ID`

Optional:

- `APP_STORE_APPLE_ID` in `codemagic.yaml` to auto-increment the uploaded TestFlight build number from App Store Connect.

The first App Store Connect app record for `online.masarsa.app` must exist before automated TestFlight publishing can complete.

## iOS Notes

The repository includes a complete Flutter iOS scaffold:

- `ios/Runner.xcodeproj`
- `ios/Runner.xcworkspace`
- `ios/Podfile`
- `ios/Runner/AppDelegate.swift`
- `ios/Runner/Assets.xcassets`
- `ios/Runner/Base.lproj`

Codemagic still keeps a guard that regenerates the scaffold if `ios/Runner.xcodeproj` is missing, but normal production builds should use the committed iOS project.

## Production Readiness Gaps

- Replace the generated placeholder app icons with final branded MASARSA artwork before public App Store release.
- Add Firebase configuration files only when native Firebase SDKs are introduced.
- Add privacy policy, support URL, screenshots, age rating, and App Store category in App Store Connect.
- Add crash reporting, analytics consent, and release monitoring.
- Add role-aware native deep links for parent, driver, and school dashboards.
- Add offline and degraded-network states for route and pickup information.
- Add driver location permission flows if native GPS tracking moves into Flutter.
