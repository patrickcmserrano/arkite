# Quick Start Guide

## Prerequisites

1. **Enable Developer Mode** (for Windows builds)
   ```powershell
   start ms-settings:developers
   ```
   Enable "Developer Mode" in the settings

2. **Get a Gemini API Key**
   - Visit: https://makersuite.google.com/app/apikey
   - Create a new API key
   - Keep it handy for first-time setup

## Running the App

### Option 1: Run on Chrome (Recommended for testing)
```bash
flutter run -d chrome
```

### Option 2: Run on Windows (requires Developer Mode)
```bash
flutter run -d windows
```

### Option 3: Run on Android/iOS Emulator
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

## First-Time Setup

1. **Launch the app** - You'll see the Welcome Screen
2. **Enter your Gemini API Key** - Paste your API key from Google AI Studio
3. **Save** - The key is securely stored using flutter_secure_storage

## Using the App

### Creating a Project
1. On the Project List screen, tap the **"New Project"** button
2. Enter a **project title** (required)
3. Optionally add a **system instruction** (global context for all conversations)
4. Tap **"Create"**

### Starting a Conversation
1. Tap on any project card
2. Type your message in the input field at the bottom
3. Press **Send** or hit Enter
4. Wait for the AI response (you'll see a "Thinking..." indicator)

### Managing Projects
1. Tap the **⋮** menu on any project card
2. Select **"Delete Project"** to remove it (with confirmation)

## Development Commands

### Generate Code (after modifying providers)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run Tests
```bash
flutter test
```

### Analyze Code
```bash
flutter analyze
```

### Clean Build
```bash
flutter clean
flutter pub get
```

## Troubleshooting

### "API Key not found" error
- Go back to the Welcome Screen and re-enter your API key
- Make sure you copied the full key from Google AI Studio

### Build errors on Windows
- Ensure Developer Mode is enabled
- Try running `flutter clean` and `flutter pub get`

### Provider generation errors
- Run `dart run build_runner clean`
- Then run `dart run build_runner build --delete-conflicting-outputs`

### Database issues
- The app stores data in your local documents folder
- To reset: delete the Isar database files and restart the app

## Project Structure

```
lib/
├── io/                          # Data layer
│   ├── isar_repository.dart     # Database operations
│   └── storage/
│       └── secure_storage.dart  # API key storage
├── kernel/                      # Business logic
│   ├── models/                  # Data models
│   │   ├── node.dart
│   │   └── project.dart
│   ├── providers/               # Riverpod providers
│   │   ├── core_providers.dart
│   │   └── project_providers.dart
│   └── services/                # External services
│       └── gemini_service.dart
└── ui/                          # Presentation layer
    ├── design_system/
    │   └── app_theme.dart
    └── features/
        ├── chat/
        │   └── chat_screen.dart
        ├── project/
        │   └── project_list_screen.dart
        └── settings/
            └── welcome_screen.dart
```

## Features

✅ **Secure API Key Storage** - Uses flutter_secure_storage
✅ **Project Management** - Create, view, and delete projects
✅ **Conversation History** - All messages saved locally with Isar
✅ **Context-Aware AI** - Conversation history passed to Gemini
✅ **Markdown Support** - AI responses rendered with formatting
✅ **Material 3 Design** - Modern, beautiful dark theme
✅ **Real-time Updates** - Project list updates automatically

## Next Steps

- Explore the codebase in `lib/`
- Check out the architecture documentation in `.agent/architecture.md`
- Read the implementation summary in `.agent/implementation_summary.md`
- Start building your AI-powered conversations!
