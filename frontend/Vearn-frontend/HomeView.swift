import SwiftUI

struct Post: Identifiable, Codable {
    let id: String
    let authorId: String
    let title: String
    let imageUrl: String
    let description: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case authorId
        case title
        case imageUrl
        case description
        case createdAt
    }
}

struct HomeView: View {
    @State private var posts: [Post] = []
    @State private var searchText: String = ""

    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Type here...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onChange(of: searchText) { _ in
                        fetchPosts()
                    }

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(filteredPosts) { post in
                            NavigationLink(destination: PostDetailsView(post: post)) {
                                VStack {
                                    AsyncImage(url: URL(string: post.imageUrl)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 175, height: 300)
                                    .background(Color.gray.opacity(0.2))
                                    .clipped()
                                    .cornerRadius(14)
                                }
                                .background(Color.blue.opacity(0.1))
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity)
            }
            .onAppear {
                fetchPosts()
            }
            .navigationTitle("Home")
        }
    }

    private var filteredPosts: [Post] {
        if searchText.isEmpty {
            return posts
        } else {
            return posts.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func fetchPosts() {
        guard let url = URL(string: "https://vearnapp.onrender.com/posts") else {
            print("❌ Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Request error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("❌ No data received")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([Post].self, from: data)
                print("✅ Decoded \(decoded.count) posts")
                DispatchQueue.main.async {
                    self.posts = decoded
                }
            } catch {
                print("❌ JSON decoding error: \(error)")
                print("Raw response:\n\(String(data: data, encoding: .utf8) ?? "N/A")")
            }
        }.resume()
    }
}

