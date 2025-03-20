# Mobile Banking App

add comments and design through copilot

## Overview
This Flutter-based mobile banking application allows users to view their bank accounts and transaction history. It utilizes JSON data to display account details and transactions. The app features smooth navigation between the Welcome Screen, Account List, and Transaction Details pages.

## Features
- **Welcome Screen**: Displays the bank logo, a welcome message, and today's date.
- **Account List**: Fetches and displays user accounts from JSON data.
- **Transaction Details**: Shows transaction history for a selected account.
- **Navigation Flow**:
  - Welcome Screen → Account List → Transaction Details
  - Users can navigate back from Transactions to Account List and from Account List to Welcome Page.

## Technologies Used
- **Flutter**: Cross-platform mobile development framework.
- **Dart**: Programming language for Flutter.
- **Intl**: Used for formatting dates.
- **JSON**: Used for storing and retrieving account and transaction data.

## Project Structure
```
mobile-banking-app/
  - android/              # Android-specific files
  - ios/                 # iOS-specific files
  - assets/
    - accounts.json      # Sample JSON data for accounts
    - transactions.json   # Sample JSON data for transactions
  - lib/
    - main.dart          # Main entry point of the application
    - screens/
      - welcome_screen.dart     # Welcome screen UI
      - account_list_screen.dart # Displays user accounts
      - transaction_screen.dart  # Shows transaction details
    - models/
      - account.dart      # Account model
      - transaction.dart  # Transaction model
    - services/
      - data_loader.dart  # Loads JSON data
  - test/                # Test files
  - pubspec.yaml         # Flutter dependencies
  - README.md            # Project documentation
```

## Setup Instructions
1. **Clone the repository:**
   ```sh
   git clone <repository-url>
   cd mobile-banking-app
   ```
2. **Install dependencies:**
   ```sh
   flutter pub get
   ```
3. **Run the application:**
   ```sh
   flutter run
   ```

## How to Use
1. Launch the app.
2. The **Welcome Screen** displays the bank logo and date.
3. Tap the **View Accounts** button to see the list of accounts.
4. Click on an account to view its transactions.
5. Navigate back as needed using the app's built-in navigation.

## License
This project is open-source and free to use.

