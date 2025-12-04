# **🏗️ Prompt IDE \- Project Specification**

Vision: A Local-First, Graph-Based IDE for Prompt Engineering.  
Philosophy: "Git for Chat". Data is immutable. Context is auditable. User is in control.

## **1\. Core Identity & Business Model**

* **Type:** Desktop-First Application (Windows/macOS) with Mobile companion.  
* **Monetization:**  
  * **Product A:** Source Code License (Flutter Boilerplate).  
  * **Product B:** End-User Binary (Lifetime License).  
* **Key Value Proposition:**  
  * **BYOK (Bring Your Own Key):** Zero server costs, direct Google API connection.  
  * **Tree-Based History:** Non-linear branching for A/B testing prompts.  
  * **Glass Box:** Full transparency on system instructions and model parameters.

## **2\. Technical Stack (Constraints)**

| Component | Technology | Rationale |
| :---- | :---- | :---- |
| **Framework** | **Flutter (Dart)** | Native performance for Desktop & Mobile from single codebase. |
| **Database** | **Isar (NoSQL)** | Synchronous/Async support, strictly typed, hyper-fast for local graph traversal. |
| **State Management** | **Riverpod 2.0** | Compile-safe, declarative, testable. No setState spaghetti. |
| **AI Client** | **google\_generative\_ai** | Official Dart SDK. Must support dynamic model IDs (e.g., gemini-1.5-pro). |
| **Graphs/UI** | **graphview** (or custom) | For visualizing the conversation tree nodes. |
| **Charts** | **fl\_chart** | For telemetry and usage visualization. |

## **3\. Architecture: The "Kernel" (Plumbing)**

The application logic must be decoupled from the UI. We follow a "Git-like" architecture.

### **3.1 Data Philosophy (Rich Hickey Style)**

* **Immutability:** Once a Node (message) is created and saved, it is **never** modified.  
* **Edits:** "Editing" a message actually forks the tree, creating a new sibling node.  
* **State:** The "Current State" is just a derived view from a pointer (headNodeId) tracing back to the root.

### **3.2 Data Schema (Isar Models)**

**Entity: Project**

Dart

class Project {  
  Id id;  
  String title;  
  String? globalSystemInstruction;  
  DateTime createdAt;  
}

**Entity: Node (The Atom)**

Dart

class Node {  
  Id id; // Unique Hash/ID  
  Id projectId;  
    
  // Graph Links  
  Id? parentId; // Null if root  
    
  // Content  
  String role; // 'user' | 'model'  
  String content; // Markdown text  
    
  // Audit Metadata (Crucial)  
  String? modelId;      // e.g., 'gemini-1.5-pro'  
  double? temperature;  // e.g., 0.7  
  int? tokenCount;  
  int? executionTimeMs; // Telemetry  
    
  DateTime timestamp;  
}

## **4\. Directory Structure (Domain-Driven)**

Do not use standard Flutter folders. Use this structure to separate Kernel from UI.

Plaintext

/lib  
  /kernel                 \# PURE DART (No Flutter UI dependencies)  
    /models               \# Isar Collections (Node, Project)  
    /logic                \# Graph traversal, history reconstruction algorithms  
    /services             \# AI Client (Gemini), Telemetry Collector  
      
  /io                     \# INFRASTRUCTURE  
    /db                   \# Isar setup, migrations  
    /storage              \# API Key secure storage  
      
  /ui                     \# FLUTTER WIDGETS (The Porcelain)  
    /design\_system        \# Atoms (Buttons, Cards, Fonts)  
    /features  
      /chat\_linear        \# The standard chat view  
      /graph\_visualizer   \# The tree view  
      /composer           \# The input area with auto-save  
      /settings           \# API Key & Model Config  
        
  main.dart

## **5\. Functional Scope (Phase 1 \- MVP)**

### **5.1 The "Happy Path"**

1. User opens app \-\> Checks for API Key \-\> If null, prompts config.  
2. User creates "New Project".  
3. User types in **Safe Composer** (Auto-saves to draft).  
4. User hits send \-\> Creates Node (User) \-\> Appends to graph.  
5. App streams response \-\> Creates Node (Model) \-\> Appends to graph.

### **5.2 Key Features**

* **Branching:** Clicking "Edit" on a past message creates a divergence.  
* **Model Selector:** Dropdown to choose between Flash/Pro/Ultra per message.  
* **Audit Badge:** Every AI response shows a small chip: ⚡ 1.5 Flash | 0.7 Temp.  
* **Draft Persistence:** If app crashes, text in input box is restored on relaunch.

## **6\. Development Rules (Linus Style)**

1. **No Magic Strings:** All Model IDs and Prompts must be constants or configurable.  
2. **Local-First:** The app must work 100% offline (except for the actual API call). No remote auth required.  
3. **Telemetry:** Every API call must be wrapped in a Stopwatch to measure TTFB (Time to First Byte).  
4. **Testing:** The Kernel must be unit-testable without a Simulator.

### ---

**🏁 Initialization Commands**

Bash

\# 1\. Create Project  
flutter create prompt\_ide \--org com.yourname \--platforms=windows,macos,android,ios

\# 2\. Add Dependencies  
flutter pub add flutter\_riverpod riverpod\_annotation  
flutter pub add isar isar\_flutter\_libs path\_provider  
flutter pub add google\_generative\_ai  
flutter pub add flutter\_markdown  
flutter pub add google\_fonts  
flutter pub add uuid

\# 3\. Add Dev Dependencies  
flutter pub add \-d isar\_generator build\_runner riverpod\_generator custom\_lint

\# 4\. Clean up  
rm lib/main.dart && touch lib/main.dart  
