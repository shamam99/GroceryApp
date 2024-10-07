//
//  plans.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct ItemSelectionView: View {
    @Binding var navigateToHome: Bool
    var listName: String
    @ObservedObject var basketManager = BasketManager.shared
    @State private var showBasketSheet = false
    @State private var searchText: String = ""

    var categories = ["Fruits", "Vegetables", "Breakfast", "Drinks", "Snacks", "Bakery", "Canned", "Cheese"]
    
    let categoryImages = [
        "Fruits": "Fruits",
        "Vegetables": "Vegetables",
        "Breakfast": "Breakfast",
        "Drinks": "Drinks",
        "Snacks": "Snacks",
        "Bakery": "Bakery",
        "Canned": "Canned",
        "Cheese": "Cheese"
    ]

    var filteredCategories: [String] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        ZStack {
            Color(red: 0.952, green: 0.949, blue: 0.972)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                }
                .padding()
                
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(7)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                ScrollView {
                    VStack {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 40) {
                            ForEach(filteredCategories, id: \.self) { category in
                                if category == "Fruits" {
                                    NavigationLink(destination: FruitItemsView(navigateToHome: $navigateToHome, listName: listName)) {
                                        categoryCardView(category: category)
                                    }
                                } else {
                                    categoryCardView(category: category)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                    .padding(-2)
                }
                .padding()
                
                Spacer()
                HStack {
                    Button(action: {
                        showBasketSheet = true
                    }) {
                        Text("View (\(basketManager.basketItems.count))")
                            .frame(width: 150, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(25)
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

    func categoryCardView(category: String) -> some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)

                Image(categoryImages[category] ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .clipped()
            }

            Text(category)
                .font(.headline)
                .foregroundColor(.black)
        }
    }
}

struct ItemSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSelectionView(navigateToHome: .constant(false), listName: "Sample List")
    }
}
