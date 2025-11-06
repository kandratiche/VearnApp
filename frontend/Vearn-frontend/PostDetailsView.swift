import SwiftUI

struct PostDetailsView: View {
    @State private var posts: [Post] = []
    let post: Post
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: post.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                .cornerRadius(12)
                .padding(.horizontal)
                
                Text(post.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(posts.filter { $0.title == post.title }) { postik in
                        NavigationLink(destination: PostDetailsView(post: postik)) {
                            VStack {
                                AsyncImage(url: URL(string: postik.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .clipped()
                                .cornerRadius(14)
                                .padding(2)
                            }
                        }
                    }
                    .cornerRadius(16)
                }
                .padding()
            }
        }
        .onAppear(perform: fetchPosts)
        .navigationTitle(post.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    func fetchPosts() {
        guard let url = URL(string: "http://127.0.0.1:5000/api/posts") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode([Post].self, from: data) {
                    DispatchQueue.main.async {
                        self.posts = decoded
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}
