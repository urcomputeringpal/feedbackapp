import SwiftUI

struct MusicPlaybackView: View {
    @Environment(\.tabViewBottomAccessoryPlacement) var placement

    var body: some View {
      switch placement {
      case .inline:
        Text("Inline Playback View")
      case .expanded:
        Text("Expanded Playback View")
      }
    }
}
