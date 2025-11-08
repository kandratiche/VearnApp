import SwiftUI

struct ContentView: View {
    var body: some View {
           TabView {
               HomeView()
                   .tabItem {
                       Label("Home", systemImage: "house")
                   }

               HomeView()
                   .tabItem {
                       Label("Favorites", systemImage: "heart")
                   }

               ProfileView()
                   .tabItem {
                       Label("Profile", systemImage: "person")
                   }
           }
       }
}

#Preview {
    ContentView()
}
