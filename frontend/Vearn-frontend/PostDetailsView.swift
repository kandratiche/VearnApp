import SwiftUI

struct PostDetailsView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: post.imageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Text(post.title)
                    .font(.title)
                    .fontWeight(.bold)
                Text(post.description)
                    .font(.body)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}
