@echo off
echo Running KDRU Guide App Tests...
echo.

echo Installing dependencies...
flutter pub get
echo.

echo Running unit tests...
flutter test test/unit/database_connection_test.dart
echo.

echo Running all tests...
flutter test test/test_runner.dart
echo.

echo Running integration tests (requires device/emulator)...
echo Note: Make sure you have a device connected or emulator running
flutter test integration_test/database_integration_test.dart
echo.

echo Tests completed!
pause
