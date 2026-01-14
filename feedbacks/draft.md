# tabViewBottomAccessory causes unstable view identity for views accessing Environment or State

|  |  |
|------------------|-------------|
| Status | Draft |

---

Views placed inside `tabViewBottomAccessory` that access `@Environment` values or contain `@State` properties experience unstable identity, as shown by `Self._printChanges()`. The identity changes on every structural update to the `TabView`, even though the view's actual identity should remain stable. This causes unnecessary view recreation and breaks SwiftUI's expected identity and lifecycle behavior.

## Environment

- Xcode Version 26.2 (17C52)
- iOS 26.2 simulator and device

## Steps to Reproduce

1. Create a `TabView` with `tabViewBottomAccessory` modifier
2. Add a view inside the accessory that accesses an `@Environment` value (e.g., `@Environment(\.tabViewBottomAccessoryPlacement)`)
3. Add a view inside the accessory that contains `@State` properties
4. Add `Self._printChanges()` to observe what SwiftUI considers changed
5. Trigger any structural change in the `TabView` (e.g., toggling `showMoreTabs` to show/hide tabs)
6. Observe the console output

## Example Code

```swift
struct AccessoryView: View {
  var body: some View {
    HStack {
      EnvironmentAccess()
      WithState()
      Stateless()
    }
  }
}

struct EnvironmentAccess: View {
  @Environment(\.tabViewBottomAccessoryPlacement) var placement

  var body: some View {
    let _ = Self._printChanges()
    Text(String(describing: type(of: self)))
  }
}

struct WithState: View {
  @State var int = Int.random(in: 0...100)
  var body: some View {
    let _ = Self._printChanges()
    Text(String(describing: type(of: self)))
  }
}

struct Stateless: View {
  var body: some View {
    let _ = Self._printChanges()
    Text(String(describing: type(of: self)))
  }
}
```

Full reproduction case: https://github.com/urcomputeringpal/feedbackapp/blob/tabViewBottomAccessory-identity/FeedbackApp/Sources/ContentView.swift

## Expected Result

When the `TabView` structure changes (tabs added/removed):
- `EnvironmentAccess`: Should only show `@self` changed, not `@identity` or environment property changes
- `WithState`: Should only show `@self` changed, not `@identity` or state property changes
- `Stateless`: Should only show `@self` changed (this works correctly)

The view identity should be stable across `TabView` structural updates when the accessory views themselves haven't changed structurally.

## Actual Result

Console output when `showMoreTabs` toggles:
```
EnvironmentAccess: @self, @identity, _placement changed.
WithState: @self, @identity, _int changed.
Stateless: @self changed.
```

Both `EnvironmentAccess` and `WithState` show `@identity` changing, along with their respective stored properties (`_placement`, `_int`). This indicates SwiftUI is treating these as different view instances rather than the same view being updated.

## Impact

- Views in `tabViewBottomAccessory` that use `@Environment` or `@State` are unnecessarily recreated on every `TabView` structural change
- This breaks expected SwiftUI identity semantics and lifecycle behavior
- Can cause performance issues with expensive view initialization
- May cause unexpected animation behavior or state loss
- Makes it difficult to maintain stable state or observe specific environment changes in accessory views
- Inconsistent behavior: stateless views work correctly, but adding environment access or state causes identity instability

## What Would Help

- Ensure views inside `tabViewBottomAccessory` maintain stable identity when their own structure hasn't changed
- Treat `TabView` structural changes as updates to the existing accessory views rather than replacements
- Align behavior with standard SwiftUI view identity rules where environment access and state storage don't affect identity
- If there's a technical reason for the current behavior, document it and provide guidance on workarounds
