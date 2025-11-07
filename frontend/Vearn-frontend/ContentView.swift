import SwiftUI

struct Post: Identifiable, Codable {
    let id: Int
    let image: String
    let title: String
}

struct ContentView: View {
    @State private var posts: [Post] = []
    
    @State private var searchText: String = ""
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        NavigationStack {
            TextField("Type here...", text: $searchText)
                .onChange(of: searchText) { newValue in
                    fetchPosts(for: newValue)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    if (searchText != "") {
                        ForEach(posts.filter {$0.title.localizedCaseInsensitiveContains(searchText) }) { post in
                            NavigationLink(destination: PostDetailsView(post: post)){
                                VStack {
                                    AsyncImage(url: URL(string: post.image)) { image in
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
                    else {
                        ForEach(posts) { post in
                            NavigationLink(destination: PostDetailsView(post: post)){
                                VStack {
                                    AsyncImage(url: URL(string: post.image)) { image in
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
                }
                .padding()
            }
            .onAppear(perform: { fetchPosts(for: "da") })
            .navigationTitle("Home")
        }
    }
    
    func fetchPosts(for query: String) {
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

#Preview {
    ContentView()
}
