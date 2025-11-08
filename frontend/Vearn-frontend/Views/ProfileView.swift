import SwiftUI

struct ProfileView: View {
    
    @State private var selectedButton = "My Works"
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .cornerRadius(50)
                    VStack {
                        Text("John Doe")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
                    Spacer()
                }
                .padding()
                HStack {
                    Button(action: {
                        selectedButton = "My Works"
                    }) {
                        Text("My Works")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedButton == "My Works" ? Color.blue : Color(UIColor.systemGray5))
                            .foregroundColor(selectedButton == "My Works" ? .white : Color.primary)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        selectedButton = "Favorites"
                    }) {
                        Text("Favorites")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedButton == "Favorites" ? Color.blue : Color(UIColor.systemGray5))
                            .foregroundColor(selectedButton == "Favorites" ? .white : Color.primary)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
