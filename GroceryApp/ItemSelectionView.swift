import SwiftUI

struct ItemSelectionView: View {
    
    @Binding var navigateToHome: Bool
    var listName: String
    @ObservedObject var basketManager = BasketManager.shared
    @State private var showBasketSheet = false
    @State private var searchText: String = ""

    var categories = ["Fruits", "Vegetables", "Breakfast", "Drinks", "Snacks", "Bakery","Canned", "Cheese"]
    
    // Assuming you have images named after each category in your Assets folder
    let categoryImages = [
        "Fruits": "Fruits",
        "Vegetables": "Vegetables",
        "Breakfast": "Breakfast",
        "Drinks": "Drinks",
        "Snacks": "Snacks",
        "Bakery": "Backery",
        "Canned": "Canned",
        "Cheese": "Cheese"
        

    ]
    
    var body: some View {
        ZStack {
            // Light gray background for the entire interface
            Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431)
                .ignoresSafeArea() // Ensures the color extends to the edges
            
            VStack {
                // Top HStack for Back Button and Title
                HStack {
                    Button(action: {
                        navigateToHome = true // Navigate to home on button tap
                    }) {
                        Image(systemName: "arrow.left") // Back arrow icon
                            .foregroundColor(.blue) // Change color as needed
                    }
                    Spacer() // Pushes the title to the center
                }
                .padding() // Padding for the top HStack
                
                // Search Bar
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(7)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Placeholder for content below the search bar
                ScrollView {
                    VStack {
                        // Adding border and background to the grid
                        LazyVGrid(columns: [
                            GridItem(.flexible()), // First column
                            GridItem(.flexible())  // Second column
                        ], spacing: 40) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    print("\(category) selected")
                                }) {
                                    VStack {
                                        ZStack {
                                            // Light gray background rectangle
                                            Rectangle()
                                                .fill(Color.white) // Set rectangle background to white
                                                .frame(width: 100, height: 100) // Size of the rectangle
                                                .cornerRadius(10)

                                            // Overlay the image on top of the rectangle
                                            Image(categoryImages[category] ?? "")
                                                .resizable()
                                                .scaledToFill() // Ensures the image fills the rectangle, may crop
                                                .frame(width: 100, height: 100) // Match the size of the rectangle
                                                .clipShape(RoundedRectangle(cornerRadius: 10)) // Clip to rounded corners
                                                .clipped() // Ensures no overflow
                                        }

                                        Text(category)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                            }
                        }
                        
                        .padding()
                        .background(Color.white) // Background color for the grid
                        .cornerRadius(20) // Rounded corners
                    }
                    
                    .padding(-2) // Padding around the grid inside the ScrollView
                }
                
                .padding()
                
                
                Spacer()
                HStack{
                    // View Button at the Bottom
                    Button(action: {
                        showBasketSheet = true
                    }) {
                        Text("View (\(basketManager.basketItems.count))")
                            .frame( width: 150, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white) // Change text color as needed
                            .cornerRadius(25) // Rounded corners for the button
                            .padding(.bottom, 20)
                    }
                }
                .sheet(isPresented: $showBasketSheet) {
                    BasketSheetView(navigateToHome: $navigateToHome, listName: listName)
                }
            }
            
        }
        .navigationBarTitle("Select Categories", displayMode: .inline)
    }
}

struct ItemSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSelectionView(navigateToHome: .constant(false), listName: "Sample List")
    }
}
