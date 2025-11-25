import SwiftUI

struct ContentView: View {
  @State var tabViewBottomAccessoryIsEnabled = true
  var body: some View {
    TabView {
      Tab("Home", systemImage: "house") { DemoView(prefix: "Home") }
      Tab("Alerts", systemImage: "bell") { DemoView(prefix: "Alerts") }
      TabSection("Categories") {
        Tab("Climate", systemImage: "fan") { DemoView(prefix: "Climate") }
        Tab("Lights", systemImage: "lightbulb") { DemoView(prefix: "Lights") }
      }
      Tab("Settings", systemImage: "gear") {
        List {
          Toggle("Tab accessory enabled", isOn: $tabViewBottomAccessoryIsEnabled)
        }
      }
    }
    .tabViewBottomAccessory(isEnabled: tabViewBottomAccessoryIsEnabled) {
      MusicPlaybackView()
    }
    .tabBarMinimizeBehavior(.onScrollDown)
  }
}

struct DemoView: View {
  let prefix: String
  var body: some View {
    List(0..<50, id: \.self) { i in
      Text("\(prefix) Item #\(i + 1)")
    }
  }
}

struct MusicPlaybackView: View {
  @Environment(\.tabViewBottomAccessoryPlacement) var placement
  var body: some View {
    if placement == .inline { ControlsPlaybackView() } else { SliderPlaybackView() }
  }
}

struct ControlsPlaybackView: View {
  var body: some View { Text("Controls") }
}

struct SliderPlaybackView: View {
  @State private var showOptionA = true
  var body: some View {
    HStack {
      if showOptionA { Text("Slider A") } else { Text("Slider B") }
      Spacer()
      Menu {
      Button {
        showOptionA.toggle()
      } label: {
        if showOptionA { Text("Option A") } else { Text("Option B") }
      }
      } label: {
        Image(systemName: "ellipsis.circle")
          .imageScale(.large)
          .padding(.horizontal)
      }
    }
    .animation(.default, value: showOptionA)
  }
}

#Preview { ContentView() }
