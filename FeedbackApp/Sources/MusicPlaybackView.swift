import SwiftUI

struct MusicPlaybackView: View {
    @Environment(\.tabViewBottomAccessoryPlacement) var placement

    var body: some View {
      switch placement {
      case .inline:
        Text("Inline")
      case .expanded:
        Text("Expanded")
      default:
        Text("Undefined")
      }
    }
}
