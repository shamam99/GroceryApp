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
    
    var body: some View {
        ZStack{
            Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431)
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
                    ForEach(fruits.indices, id: \.self) { index in
                        HStack(spacing: 20) {
                            Image(fruits[index].imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(fruits[index].name)
                                    .font(.headline)
                                Text("\(String(format: "%.2f", fruits[index].price)) SR")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // controls
                            HStack {
                                // Decrease
                                Button(action: {
                                    let currentQuantity = basketManager.getQuantity(for: fruits[index])
                                    if currentQuantity > 0 {
                                        let newQuantity = currentQuantity - 1
                                        basketManager.updateBasket(fruit: fruits[index], quantity: newQuantity)
                                    }
                                }) {
                                    Image(systemName: "minus.circle")
                                        .font(.system(size: 20))
                                        .foregroundColor(basketManager.getQuantity(for: fruits[index]) > 0 ? .blue : .gray)
                                }
                                
                                // Display quantity
                                Text("\(basketManager.getQuantity(for: fruits[index]))")
                                    .font(.headline)
                                    .frame(width: 30)
                                
                                // Increase
                                Button(action: {
                                    let newQuantity = basketManager.getQuantity(for: fruits[index]) + 1
                                    basketManager.updateBasket(fruit: fruits[index], quantity: newQuantity)
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
//                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
                
                Spacer()
                
                // show basket sheet
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
                    // pass the  list name
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

