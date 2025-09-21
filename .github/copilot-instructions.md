# Copilot Project Instructions

Purpose: Help AI agents make productive, minimal, correct changes to this Tuist‑managed SwiftUI iOS app.

## Big Picture
- Single SwiftUI iOS app target: `FeedbackApp` (defined in `Project.swift`). Entry point is `FeedbackAppApp` -> loads `ContentView`.
- Tests target: `FeedbackAppTests` using the Swift 6 `Testing` framework (`import Testing`, `@Test` functions).
- Xcode project & workspace are Tuist–generated artifacts (`FeedbackApp.xcodeproj`, `FeedbackApp.xcworkspace`). Do not hand‑edit them.
- Source layout (keep additions consistent):
  - App code: `FeedbackApp/Sources/...`
  - Resources (assets, plist additions): `FeedbackApp/Resources/...`
  - Tests: `FeedbackApp/Tests/...`

## Build / Run Loop (VS Code)
1. Edit Swift files under `FeedbackApp/Sources`.
2. Run the VS Code task: `sweetpad: build` (configured in `.vscode/tasks.json`). This triggers a Tuist/Xcode build and streams formatted diagnostics (xcbeautify matchers).
3. Fix any errors surfaced via the task problem matchers (`$sweetpad-*`).
4. Repeat.

## When Project Structure Changes
- Add / rename targets, adjust bundle IDs, or modify Info.plist keys: edit `Project.swift`.
- After changing `Project.swift`, (re)generate the Xcode project (the build task or Tuist tooling should handle this; if needed manually run `tuist generate` outside these instructions—do not commit generated artifacts beyond what’s already tracked).
- Add new source files inside existing declared `buildableFolders` (`FeedbackApp/Sources`). Tuist picks them up automatically—no need to list files explicitly.

## Adding UI Components
- Create a new SwiftUI View file with a `struct MyView: View { var body: some View { ... } }` inside `FeedbackApp/Sources`.
- Keep visibility `internal` (default) unless the type must be imported by tests or another module (currently only one module, so `public` generally unnecessary—`ContentView` is currently `public` but could be internal).

## Tests
- Place test files in `FeedbackApp/Tests`.
- Pattern:
  ```swift
  import Testing
  @testable import FeedbackApp
  struct FeatureTests {
      @Test func doesThing() throws { /* #expect(...) */ }
  }
  ```
- Use `#expect(condition)` for assertions. Add async by declaring the test `async`.

## Conventions & Notes
- Do not edit `Derived/` contents; they are build outputs.
- Prefer updating `Project.swift` instead of touching plist files directly (it extends default Info.plist with keys like `UILaunchScreen`).
- Keep instructions minimal—avoid introducing external build tools unless already configured.
- Avoid adding dependencies until a Tuist manifest change is made (currently `dependencies: []`).

## Safe Changes Examples
- Add a new SwiftUI view & reference it from `ContentView`.
- Add a test in `FeedbackApp/Tests` validating view state or pure logic.
- Extend Info.plist keys via `Project.swift` if a capability is required.

## Out of Scope For Automation (Manual / Future)
- Code signing / provisioning profile setup.
- Distribution (TestFlight / App Store) workflows.

Clarify anything unclear before large changes (e.g., introducing additional modules or external packages).
