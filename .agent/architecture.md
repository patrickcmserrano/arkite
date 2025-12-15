# Arkite - Project Structure

## Application Flow

```
┌─────────────────────────────────────────────────────────────┐
│                         main.dart                            │
│  ┌────────────────────────────────────────────────────┐     │
│  │  Check API Key (apiKeyProvider)                    │     │
│  └────────────────┬───────────────────────────────────┘     │
│                   │                                          │
│         ┌─────────┴─────────┐                               │
│         │                   │                               │
│    No API Key          Has API Key                          │
│         │                   │                               │
│         ▼                   ▼                               │
│  ┌─────────────┐    ┌──────────────────┐                   │
│  │  Welcome    │    │  ProjectList     │                   │
│  │  Screen     │    │  Screen          │                   │
│  └─────────────┘    └────────┬─────────┘                   │
│                              │                              │
│                              │ Tap Project                  │
│                              ▼                              │
│                      ┌──────────────────┐                   │
│                      │  Chat Screen     │                   │
│                      └──────────────────┘                   │
└─────────────────────────────────────────────────────────────┘
```

## Data Layer

```
┌─────────────────────────────────────────────────────────────┐
│                    Isar Database (Local)                     │
│  ┌──────────────────────┐    ┌──────────────────────┐       │
│  │     Project          │    │       Node           │       │
│  ├──────────────────────┤    ├──────────────────────┤       │
│  │ id: int              │    │ id: int              │       │
│  │ title: String        │◄───┤ projectId: int       │       │
│  │ systemInstruction?   │    │ role: String         │       │
│  │ createdAt: DateTime  │    │ content: String      │       │
│  └──────────────────────┘    │ parent: IsarLink     │       │
│                               │ timestamp: DateTime  │       │
│                               └──────────────────────┘       │
└─────────────────────────────────────────────────────────────┘
```

## Provider Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Riverpod Providers                        │
│                                                              │
│  Core Providers (core_providers.dart)                       │
│  ├─ isarRepositoryProvider                                  │
│  ├─ secureStorageProvider                                   │
│  ├─ apiKeyProvider                                          │
│  └─ geminiServiceProvider                                   │
│                                                              │
│  Project Providers (project_providers.dart)                 │
│  ├─ projectListProvider (Stream)                            │
│  └─ projectManagerProvider (Notifier)                       │
│      ├─ createProject()                                     │
│      ├─ deleteProject()                                     │
│      └─ updateProject()                                     │
└─────────────────────────────────────────────────────────────┘
```

## Service Layer

```
┌─────────────────────────────────────────────────────────────┐
│                    GeminiService                             │
│  ┌────────────────────────────────────────────────────┐     │
│  │  generateContent(prompt, history)                  │     │
│  │  ├─ Converts Node[] → Content[]                    │     │
│  │  ├─ Sends to Gemini API                            │     │
│  │  └─ Returns AI response                            │     │
│  │                                                     │     │
│  │  generateContentStream(prompt)                     │     │
│  │  └─ Returns streaming response                     │     │
│  └────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

## UI Components

```
┌─────────────────────────────────────────────────────────────┐
│                    UI Features                               │
│                                                              │
│  features/settings/                                          │
│  └─ welcome_screen.dart                                     │
│      └─ API key input & storage                            │
│                                                              │
│  features/project/                                           │
│  └─ project_list_screen.dart                                │
│      ├─ Project cards                                       │
│      ├─ Create project dialog                               │
│      └─ Delete confirmation                                 │
│                                                              │
│  features/chat/                                              │
│  └─ chat_screen.dart                                        │
│      ├─ Message bubbles (user/AI)                           │
│      ├─ Markdown rendering                                  │
│      ├─ Message input                                       │
│      └─ Auto-scroll                                         │
│                                                              │
│  design_system/                                              │
│  └─ app_theme.dart                                          │
│      └─ Material 3 dark theme                               │
└─────────────────────────────────────────────────────────────┘
```

## Key Technologies

- **Flutter**: UI framework
- **Riverpod**: State management
- **Isar**: Local NoSQL database
- **Google Generative AI**: Gemini API integration
- **flutter_markdown**: Markdown rendering
- **Google Fonts**: Typography (Inter)
- **flutter_secure_storage**: Secure API key storage

## Conversation Flow

```
User sends message
      │
      ▼
Create Node (role: 'user')
      │
      ▼
Save to Isar DB
      │
      ▼
Get conversation history
      │
      ▼
Convert Node[] → Content[]
      │
      ▼
Send to Gemini API
      │
      ▼
Receive AI response
      │
      ▼
Create Node (role: 'model')
      │
      ▼
Link to parent (user node)
      │
      ▼
Save to Isar DB
      │
      ▼
Display in chat UI
```
