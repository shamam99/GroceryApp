//
//  BasketSheetView.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct BasketSheetView: View {
    @Binding var navigateToHome: Bool
    @ObservedObject var basketManager = BasketManager.shared
    @State private var navigateToMyList = false
    
    var listName: String

    var body: some View {
        NavigationView {
            VStack {
                Text("My Basket")
                    .font(.largeTitle)
                    .padding(.top, 20)
                
                ScrollView {
                    ForEach(basketManager.basketItems, id: \.self) { fruit in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(fruit.name)
                                    .font(.headline)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    if !listName.isEmpty && !basketManager.basketItems.isEmpty {
                        basketManager.createList(name: listName)
                        navigateToHome = true
                    }
                }) {
                    Text("Create")
                        .frame(width: 150, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.bottom, 20)
                }
                
                NavigationLink(
                    destination: MyListView(navigateToHome: $navigateToHome),
                    isActive: $navigateToMyList
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("My Basket", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                navigateToMyList = true
            })
        }
    }
}

// Preview for BasketSheetView
struct BasketSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BasketSheetView(navigateToHome: .constant(false), listName: "Sample List")
    }
}









