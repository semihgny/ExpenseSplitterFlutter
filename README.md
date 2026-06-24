# ExpenseSplitterFlutter

A mobile application built with Flutter for tracking shared expenses, managing group budgets, and settling debts easily.

## Features

- **Group Management**: Create events, trips, or groups and add participants.
- **Expense Tracking**: Log expenses with support for equal, exact amount, and percentage-based splitting.
- **Debt Simplification**: Automatically calculates the minimum number of transactions required to settle all debts.
- **Multi-Currency Support**: Natively supports multiple currencies including USD, EUR, and TRY.
- **PDF Export**: Generate detailed, elegant PDF reports of group expenses and share them directly.
- **Offline-First**: Fully functional without an internet connection using a local database.

## Technologies Used

- **Flutter & Dart**: For building the declarative user interface and handling cross-platform logic.
- **Riverpod**: For robust, reactive state management.
- **Drift (SQLite)**: For safe and type-safe offline storage.
- **Go Router**: For declarative routing and navigation.
- **PDF & Printing**: For dynamic PDF report creation and sharing.
- **MVVM Architecture**: Clean separation of concerns between Views, Controllers (ViewModels), and Services.

## Requirements

- Flutter SDK (3.12.1 or later recommended)
- Dart SDK
- Xcode 14.0+ (for iOS deployment)
- Android Studio / Android SDK (for Android deployment)

## Installation

Clone the repository:
```bash
git clone https://github.com/semihgny/ExpenseSplitterFlutter.git
cd ExpenseSplitterFlutter
```

Get dependencies:
```bash
flutter pub get
```

Generate database and provider files:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Build and Run: 
Select your preferred iOS Simulator, Android device, or macOS target and run the application.
```bash
flutter run
```

## Contributing

Contributions are welcome! If you'd like to improve the project, please fork the repository and submit a pull request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.
