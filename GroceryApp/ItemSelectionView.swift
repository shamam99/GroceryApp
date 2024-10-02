//
//  ItemSelectionView.swift
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
    
    var categories = ["Fruits", "Vegetables", "Breakfast", "Drinks", "Snack", "Bakery"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(listName)")
                    .font(.largeTitle)
                    .padding(.top, 50)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(categories, id: \.self) { category in
                            if category == "Fruits" {
                                NavigationLink(destination: FruitItemsView(navigateToHome: $navigateToHome, listName: listName)) {
                                    CategoryCard(category: category)
                                }
                            } else {
                                CategoryCard(category: category)
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    showBasketSheet = true
                }) {
                    Text("View (\(basketManager.basketItems.count))")
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.bottom, 10)
                }
                .sheet(isPresented: $showBasketSheet) {
                    BasketSheetView(navigateToHome: $navigateToHome, listName: listName)
                }
            }
            .navigationBarTitle("Select Categories", displayMode: .inline)
        }
    }
}

struct ItemSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSelectionView(navigateToHome: .constant(false), listName: "Sample List")
    }
}

