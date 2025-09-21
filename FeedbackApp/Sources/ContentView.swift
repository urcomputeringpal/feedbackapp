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
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
