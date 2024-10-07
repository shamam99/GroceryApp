//
//  FruitItemsView.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct FruitItemsView: View {
    @Binding var navigateToHome: Bool
    var listName: String
    @ObservedObject var basketManager = BasketManager.shared
    @State private var fruits = sampleFruits
    @State private var searchText = ""
    @State private var showBasketSheet = false
    @State private var navigateToMyList = false
    @State private var localNavigateToHome = false
    
    var filteredFruits: [FruitItem] {
        if searchText.isEmpty {
            return fruits
        } else {
            return fruits.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.952, green: 0.949, blue: 0.972)
                .ignoresSafeArea()
            
            VStack {
                Text("Fruits")
                    .font(.largeTitle)
                    .padding(.top, 20)
                    .bold()
                
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(7)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, -4)
                
                ScrollView {
                    ForEach(filteredFruits.indices, id: \.self) { index in
                        HStack(spacing: 20) {
                            Image(filteredFruits[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(filteredFruits[index].name)
                                    .font(.headline)
                                Text("\(String(format: "%.2f", filteredFruits[index].price)) SR")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    let currentQuantity = basketManager.getQuantity(for: filteredFruits[index])
                                    if currentQuantity > 0 {
                                        let newQuantity = currentQuantity - 1
                                        basketManager.updateBasket(fruit: filteredFruits[index], quantity: newQuantity)
                                    }
                                }) {
                                    Image(systemName: "minus.circle")
                                        .font(.system(size: 20))
                                        .foregroundColor(basketManager.getQuantity(for: filteredFruits[index]) > 0 ? .blue : .gray)
                                }
                                
                                Text("\(basketManager.getQuantity(for: filteredFruits[index]))")
                                    .font(.headline)
                                    .frame(width: 30)
                                
                                Button(action: {
                                    let newQuantity = basketManager.getQuantity(for: filteredFruits[index]) + 1
                                    basketManager.updateBasket(fruit: filteredFruits[index], quantity: newQuantity)
                                }) {
                                    Image(systemName: "plus.circle")
                                        .font(.system(size: 20))
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    showBasketSheet = true
                }) {
                    Text("View (\(basketManager.totalCount))")
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.bottom, 20)
                }
                .sheet(isPresented: $showBasketSheet) {
                    BasketSheetView(navigateToHome: $navigateToHome, listName: listName)
                }
                
                NavigationLink(
                    destination: MyListView(navigateToHome: $navigateToHome),
                    isActive: $navigateToMyList
                ) {
                    EmptyView()
                }
            }
        }
        .navigationBarTitle("Fruit Items", displayMode: .inline)
        .navigationBarItems(trailing: Button("Done") {
            localNavigateToHome = true
        })
        .fullScreenCover(isPresented: $localNavigateToHome) {
            HomeView()
        }
    }
}

struct FruitItemsView_Previews: PreviewProvider {
    static var previews: some View {
        FruitItemsView(navigateToHome: .constant(false), listName: "Sample List")
    }
}

