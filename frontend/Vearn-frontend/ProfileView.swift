import SwiftUI

struct ProfileView: View {
    
    @State private var selectedButton = "My Works"
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image("person")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .background(Color.black).opacity(0.2)
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
                            .background(selectedButton == "My Works" ? Color.blue : Color.gray.opacity(0.3))
                            .foregroundColor(selectedButton == "My Works" ? .white : .black)
                            .cornerRadius(10)
                    }

                    // Button 2
                    Button(action: {
                        selectedButton = "Favorites"
                    }) {
                        Text("Favorites")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedButton == "Favorites" ? Color.blue : Color.gray.opacity(0.3))
                            .foregroundColor(selectedButton == "Favorites" ? .white : .black)
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
