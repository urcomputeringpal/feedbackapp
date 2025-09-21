import SwiftUI

// A simple model representing an example item.
struct ExampleItem: Identifiable {
    let id = UUID()
    let name: String
    let imageURL: URL

    static let imageURL = URL(string: "https://picsum.photos/500.jpg")!

    // Sample data displayed in the scroll view.
    static let sample: [ExampleItem] = [
        "Aurora Borealis",
        "Crimson Canyon",
        "Emerald Forest",
        "Golden Dunes",
        "Midnight Ocean",
        "Silent Mountains",
        "Velvet Desert",
        "Misty Valley",
        "Silver Glacier",
        "Twilight Meadow"
    ].map { ExampleItem(name: $0, imageURL: ExampleItem.imageURL) }
}

struct ExampleScrollView: View {
    let items: [ExampleItem]

    init(items: [ExampleItem] = ExampleItem.sample) {
        self.items = items
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(items) { item in
                    ExampleCardView(item: item)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel("\(item.name) image card")
                }
            }
            .padding(.vertical, 20)
        }
    }
}

private struct ExampleCardView: View {
    let item: ExampleItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: item.imageURL) { phase in
                switch phase {
                case .empty:
                    ZStack { ProgressView() }.frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                        .clipped()
                case .failure:
                    ZStack { Image(systemName: "photo") }
                        .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 250)
                        .foregroundColor(.secondary)
                @unknown default:
                    EmptyView()
                }
            }
            .accessibilityHidden(true)

            Text(item.name)
                .font(.headline)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
        .padding(.horizontal, 20)
    }
}

#if DEBUG
struct ExampleScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleScrollView()
            .previewDisplayName("Example Scroll View")
    }
}
#endif
