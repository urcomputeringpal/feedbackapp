import SwiftUI

public struct ContentView: View {
    public init() {}

    public var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                ExampleScrollView()
            }


            Tab("Alerts", systemImage: "bell") {
                ExampleScrollView()
            }


            TabSection("Categories") {
                Tab("Climate", systemImage: "fan") {
                            ExampleScrollView()

                }


                Tab("Lights", systemImage: "lightbulb") {
                            ExampleScrollView()

                }
            }
        }
         .tabViewBottomAccessory {
             MusicPlaybackView()
         }
        .tabBarMinimizeBehavior(.onScrollDown)
        .tabViewStyle(.sidebarAdaptable)
// Not affected by bug
//        .overlay(alignment: .top) {
//            MusicPlaybackView(inAccessory: false)
//            .frame(maxWidth: .infinity, maxHeight: 60)
//            .background(.ultraThinMaterial.opacity(0.5))
//        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
