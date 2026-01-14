import SwiftUI

struct ContentView: View {
  @State var showMoreTabs = true

  struct DemoTab: View {
    var body: some View { Text(String(describing: type(of: self))) }
  }

  var body: some View {
    TabView {
      Tab("Home", systemImage: "house") { DemoTab() }
      Tab("Alerts", systemImage: "bell") { DemoTab() }
      if showMoreTabs {
        TabSection("Categories") {
          Tab("Climate", systemImage: "fan") { DemoTab() }
          Tab("Lights", systemImage: "lightbulb") { DemoTab() }
        }
      }
      Tab("Settings", systemImage: "gear") {
        List {
          Toggle("Show more Tabs", isOn: $showMoreTabs)
        }
      }
    }
    .tabViewBottomAccessory {
      AccessoryView()
    }
    .task {
      while true {
        try? await Task.sleep(for: .seconds(5))
        if Task.isCancelled { break }
        print("toggling showMoreTabs")
        showMoreTabs.toggle()
      }
    }
    .tabBarMinimizeBehavior(.onScrollDown)
  }
}

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
    // FIXME: EnvironmentAccess: @self, @identity, _placement changed.
    // Identity should be stable
    let _ = Self._printChanges()
    Text(String(describing: type(of: self)))  }
}

struct WithState: View {
  @State var int = Int.random(in: 0...100)
  var body: some View {
    // FIXME: WithState: @self, @identity, _id changed.
    // Identity should be stable
    let _ = Self._printChanges()
    Text(String(describing: type(of: self)))
  }
}

struct Stateless: View {
  var body: some View {
    // Works as expected: Stateless: @self changed.
    let _ = Self._printChanges()
    Text(String(describing: type(of: self)))
  }
}


#Preview { ContentView() }
