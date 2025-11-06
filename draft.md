# tabViewBottomAccessory content is recreated on every TabView selection change

When using the new `tabViewBottomAccessory` API with a `TabView`, the accessory content is recreated every time the tab selection changes, even when the accessory itself is identical for all tabs. This causes unnecessary view reconstruction, repeated side effects, and state loss in the accessory.

## Environment

- Xcode 26.2 beta (17C5013i)
- iOS 26.1 device
- iOS 26.2 simulator (iPhone 17 Pro) — reproduces with identical behavior

## Steps to Reproduce

- Run the app on a device or simulator.
- Toggle the slider type in the accessory using the button.
- Switch between any tabs and observe the accessory’s state.

## Example Code

- TODO

## Expected Result

- `SliderPlaybackView.init` runs once when the `TabView` is presented (or only when structurally required).
- `SliderPlaybackView.body` recomputes as needed without resetting `@State`.
- Switching tabs preserves the accessory’s local state.

## Actual Result

- Each tab switch triggers `SliderPlaybackView.init` and `SliderPlaybackView.body`.
- `@State` resets to its initial value, losing the selected slider option.
- The accessory hierarchy appears to be torn down and rebuilt on every selection change despite not depending on the selected tab.

## Diagnostics

- Added `print("init SliderPlaybackView")` inside `init` and `onAppear`/`onDisappear` in `SliderPlaybackView` to instrument lifecycle.
- Logs show `init` + `onAppear` firing on every tab selection change, confirming reconstruction without accessory changes.

## Impact

- Expensive accessory work (network, animations, layout) repeats on each tab switch.
- Local state stored in the accessory (`@State`, `@StateObject`, etc.) cannot persist between tabs.
- The current behavior prevents using `tabViewBottomAccessory` for persistent UI.
