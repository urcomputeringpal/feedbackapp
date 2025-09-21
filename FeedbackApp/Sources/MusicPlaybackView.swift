import SwiftUI

struct MusicPlaybackView: View {
    @Environment(\.tabViewBottomAccessoryPlacement) var placement
    @AppStorage("toggle") private var isOn: Bool = false
    var inAccessory = true

    var body: some View {
// The presence of any container at this level seems to force the value of
// placement to nil?
//      Group {
        switch placement {
        case .inline:
          ControlsPlaybackView()
        case .expanded:
          SliderPlaybackView(inAccessory: inAccessory)
        default:
          // This seems to be rendered when an AttributeGraph cycles happens at
          // this view level
          SliderPlaybackView(inAccessory: inAccessory)
        }
//      }
    }
}


struct ControlsPlaybackView: View {
  var body: some View {
    HStack {
      ValidContentsView()
    }
  }
}

struct SliderPlaybackView: View {
  var inAccessory: Bool = true
  var body: some View {
    HStack {
      SliderView(inAccessory: inAccessory)
      ControlsPlaybackView()
    }
  }
}

struct SliderView: View {
  @AppStorage("toggle") private var isOn: Bool = false
  var inAccessory: Bool = true
  var body: some View {
    Text(isOn ? "Slider while on" : "Slider while off")
//
// Simply having this conditional present triggers AttributeGraph cycles when
// rendered through tabViewBottomAccessory
//
//    if !inAccessory {
//
// Any / all of the below views trigger AttributeGraph cycles when rendered as a
// part of a tabViewBottomAccessory. When these cycles are present, other
// parts of the tabViewBottomAccessory tree can display odd behavior, like
// the values of a toggle not showing.
//
//       ActualSliderView()
//       BrokenButtonView()
//       EncapsulatedConditionalContentView()
//       BrokenToggleView()
//       BrokenButtonView()
//       ProgressViewInHStack()
//    }
  }
}

struct ValidContentsView: View {
  @AppStorage("toggle") private var isOn: Bool = false

  var body: some View {
    HStack {
      ConditionalContentInLabelView(isOn: isOn)
      Menu(content: {
        Button {
          if isOn {
            print("on")
          } else {
            print("off")
          }
        } label: {
          if isOn {
            Text("Action")
          } else {
            Text("Action while off")
          }
        }
      }, label: {
        Text("Menu")
      })
      Text(isOn ? "On" : "Off")
        .onTapGesture {
          isOn.toggle()
        }
    }
    .animation(.default.speed(0.5), value: isOn)
  }
}

// Does not trigger attribute cycle
struct ConditionalContentInLabelView: View {
  var isOn: Bool = false
  var body: some View {
    // This seems to work!
    Label {
      if isOn {
        Text("slider")
      } else {
        Text("slider2")
      }
    } icon: {
      // Any conditional content here is very glitchy
      Image(systemName: "pin")
//      Image(systemName: isOn ? "pin.fill" : "pin")
      // very glitchy
//        .symbolVariant(isOn ? .fill : .none)
      // triggers attribute cycle
//      if isOn {
//        Image(systemName: "pin.fill")
//      } else {
//        Image(systemName: "pin.slash")
//      }
    }
  }
}

// Triggers attribute cycle
struct ActualSliderView: View {
  @State private var value: Double = 0.5

  var body: some View {
    Slider(value: $value)
  }
}

// Triggers attribute cycle
struct EncapsulatedConditionalContentView: View {
  var isOn: Bool = false
  var body: some View {
    VStack {
      if isOn {
        Text("slider")
      } else {
        Text("slider2")
      }
    }
  }
}

// Triggers attribute cycle
struct BrokenToggleView: View {
  @State private var isOn: Bool = false

  var body: some View {
    Toggle("Toggle", isOn: $isOn)
  }
}

// Triggers attribute cycle
struct BrokenButtonView: View {
  @State private var isOn: Bool = false

  var body: some View {
    Button {
      isOn.toggle()
    } label: {
      Text("Toggle")
    }
  }
}


// Triggers attribute cycle
struct ProgressViewInHStack: View {
  var body: some View {
    HStack {
      ProgressView()
    }
  }
}
