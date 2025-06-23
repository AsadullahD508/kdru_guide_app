# Kdru Guide App - Test Suite

This directory contains comprehensive tests for the Kdru Guide App, including unit tests, widget tests, and integration tests.

## Test Structure

```
test/
├── unit/                          # Unit tests for business logic
│   ├── language_provider_test.dart    # Language provider functionality
│   ├── app_localizations_test.dart    # Localization system
│   └── responsive_utils_test.dart     # Responsive design utilities
├── widget/                        # Widget tests for UI components
│   ├── home_screen_test.dart          # Home screen widget tests
│   └── teacher_search_test.dart       # Search functionality tests
├── integration/                   # Integration tests for full app flows
│   └── app_integration_test.dart      # End-to-end app testing
├── test_runner.dart              # Test runner script
└── README.md                     # This file
```

## Running Tests

### Prerequisites

Make sure you have the required dependencies installed:

```bash
flutter pub get
```

### Unit Tests

Run all unit tests:
```bash
flutter test test/unit/
```

Run specific unit test files:
```bash
flutter test test/unit/language_provider_test.dart
flutter test test/unit/app_localizations_test.dart
flutter test test/unit/responsive_utils_test.dart
```

### Widget Tests

Run all widget tests:
```bash
flutter test test/widget/
```

Run specific widget test files:
```bash
flutter test test/widget/home_screen_test.dart
flutter test test/widget/teacher_search_test.dart
```

### Integration Tests

Run integration tests (requires a device or emulator):
```bash
flutter test integration_test/app_integration_test.dart
```

### All Tests

Run all tests at once:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

## Test Categories

### 1. Unit Tests

#### Language Provider Tests (`language_provider_test.dart`)
- Language switching functionality
- Text direction handling (RTL/LTR)
- Font family selection
- Localized string retrieval
- Error handling

#### Localization Tests (`app_localizations_test.dart`)
- Key availability across all languages
- String consistency validation
- Character encoding validation
- Missing key handling
- Language-specific content validation

#### Responsive Utils Tests (`responsive_utils_test.dart`)
- Screen size detection (mobile/tablet/desktop)
- Responsive font sizing
- Responsive spacing calculations
- Grid layout adaptations
- Responsive padding calculations

### 2. Widget Tests

#### Home Screen Tests (`home_screen_test.dart`)
- Loading state handling
- Main content rendering
- Faculty card display
- Navigation functionality
- Language support
- Error handling
- Responsive design

#### Teacher Search Tests (`teacher_search_test.dart`)
- Search input functionality
- Search state management
- Language support
- UI component rendering
- Error handling
- Accessibility features

### 3. Integration Tests

#### App Integration Tests (`app_integration_test.dart`)
- App launch and initialization
- Navigation flows
- Search functionality end-to-end
- Back button behavior
- Exit confirmation
- Performance testing
- Memory management
- Accessibility validation

## Test Coverage Areas

### ✅ Covered Features

1. **Language Management**
   - Language switching (Pashto, Dari, English)
   - Text direction (RTL/LTR)
   - Font family selection
   - Localization string retrieval

2. **UI Components**
   - Home screen rendering
   - Search functionality
   - Navigation components
   - Responsive design

3. **User Interactions**
   - Faculty card navigation
   - Search operations
   - Back button handling
   - Exit confirmation

4. **Error Handling**
   - Network errors
   - Missing data
   - Invalid inputs
   - Provider errors

5. **Accessibility**
   - Screen reader support
   - Semantic labels
   - Focus management

6. **Performance**
   - Load times
   - Memory usage
   - Rapid navigation

### 🔄 Areas for Future Testing

1. **Firebase Integration**
   - Database operations
   - Authentication
   - Real-time updates

2. **Advanced UI Components**
   - Faculty detail pages
   - Teacher profiles
   - Administration screens

3. **Offline Functionality**
   - Cached data handling
   - Network connectivity

4. **Advanced Search**
   - Filter functionality
   - Search history
   - Advanced queries

## Writing New Tests

### Unit Test Template

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/your_class.dart';

void main() {
  group('YourClass Tests', () {
    late YourClass yourClass;

    setUp(() {
      yourClass = YourClass();
    });

    test('should do something', () {
      // Arrange
      final input = 'test input';
      
      // Act
      final result = yourClass.doSomething(input);
      
      // Assert
      expect(result, equals('expected output'));
    });
  });
}
```

### Widget Test Template

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/your_widget.dart';

void main() {
  group('YourWidget Tests', () {
    testWidgets('should render correctly', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: YourWidget(),
        ),
      );

      // Act & Assert
      expect(find.byType(YourWidget), findsOneWidget);
      expect(find.text('Expected Text'), findsOneWidget);
    });
  });
}
```

## Best Practices

1. **Test Naming**: Use descriptive test names that explain what is being tested
2. **Arrange-Act-Assert**: Structure tests with clear sections
3. **Mock Dependencies**: Use mocks for external dependencies
4. **Test Edge Cases**: Include tests for error conditions and edge cases
5. **Keep Tests Independent**: Each test should be able to run independently
6. **Use Groups**: Organize related tests using `group()` functions
7. **Clean Up**: Use `setUp()` and `tearDown()` for test preparation and cleanup

## Continuous Integration

These tests are designed to run in CI/CD pipelines. Make sure to:

1. Run tests on multiple Flutter versions
2. Test on different platforms (Android, iOS)
3. Include test coverage reporting
4. Fail builds on test failures

## Troubleshooting

### Common Issues

1. **Mock Setup**: Ensure all mocks are properly configured
2. **Async Operations**: Use `pumpAndSettle()` for async operations
3. **Widget Finding**: Use appropriate finders for UI elements
4. **Test Isolation**: Ensure tests don't affect each other

### Debug Tips

1. Use `debugDumpApp()` to see widget tree
2. Use `printOnFailure()` for debug output
3. Add breakpoints in test code
4. Check test output for detailed error messages
