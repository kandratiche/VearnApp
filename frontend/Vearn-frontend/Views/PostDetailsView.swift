import SwiftUI

struct PostDetailsView: View {
    let post: Post
    
    @State private var some = 1
    
    @State private var favorite: Bool = false
    @State private var posts: [Post] = []
    @State private var showAlert = false
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: post.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    if(post.description == "") {
                    }
                    else {
                        Text(post.description)
                            .font(.body)
                    }
                    HStack {
                        Button(action: {
                            favorite.toggle()
                            showAlert = true
                        }) {
                            Image(systemName: favorite ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        
                        .alert(favorite ? "Added to favorites" : "Removed from favorites", isPresented: $showAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        .frame(width: 20, height: 20)
                        
                        Button(action: {
                            some += 1
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 20, height: 20)
                        
                        Button(action: {
                            some += 1
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 20, height: 20)
                    }
                    Spacer()
                }
                .padding()
                
                if posts.isEmpty {
                    Text("Loading related posts...")
                        .foregroundColor(.gray)
                } else {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(posts) { p in
                            NavigationLink(destination: PostDetailsView(post: p)) {
                                VStack {
                                    AsyncImage(url: URL(string: p.imageUrl)) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 175, height: 300)
                                    .clipped()
                                    .cornerRadius(14)
                                }
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal)
                }
            }
            .navigationTitle(post.title)
            .onAppear {
                fetchPosts()
            }
        }
    }
    
    
    
    private func fetchPosts() {

        let words = post.title.split(separator: " ").map { String($0) }
        let searchQuery = words.joined(separator: " ")

        let encodedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""

        guard let url = URL(string: "https://vearnapp.onrender.com/posts/title/\(encodedQuery)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = decoded
                }
                print(decoded)
            } catch {
                print("JSON decoding error: \(error)")
                print("Raw response:\n\(String(data: data, encoding: .utf8) ?? "N/A")")
            }
        }.resume()
    }

}


#Preview {
    PostDetailsView(post: Post(
        id: "690e41f117d073aaaef39bf5",
        authorId: "690e408467671be32c2ec095",
        title: "Sunrise mountain",
        imageUrl: "data:image/jpeg;base64,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",
        description: "Beautiful mountains",
        createdAt: "2025-11-07T19:01:05.407+00:00"
    ))
}
