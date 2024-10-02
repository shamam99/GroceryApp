//
//  ListDetailView.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct ListDetailView: View {
    var listName: String
    @ObservedObject var basketManager = BasketManager.shared
    @State private var showBudgetSheet = false
    @State private var enteredMinBudget: String = ""
    @State private var enteredMaxBudget: String = ""
    @State private var navigateToPlans = false

    var body: some View {
        VStack {
            Text("Details for \(listName)")
                .font(.largeTitle)
                .padding(.top, 20)
            
            
            if let list = basketManager.createdLists.first(where: { $0.name == listName }) {
                ScrollView {
                    ForEach(list.items, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text("\(String(format: "%.2f", item.price)) SR")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Quantity: \(item.quantity)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
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
                
                // Nav to Plans view
                NavigationLink(
                    destination: Plans(
                        minBudget: Double(enteredMinBudget) ?? 0.0,
                        maxBudget: Double(enteredMaxBudget) ?? 0.0,
                        items: mapFruitItemsToPlanItems(list.items)
                    ),
                    isActive: $navigateToPlans
                ) {
                    EmptyView()
                }
            } else {
                Text("No items in this list")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                showBudgetSheet = true
            }) {
                Text("Set Budget")
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.bottom, 20)
            }
            .sheet(isPresented: $showBudgetSheet) {
                BudgetEntrySheet(minBudget: $enteredMinBudget, maxBudget: $enteredMaxBudget, onDone: {
                    showBudgetSheet = false
                    navigateToPlans = true // nav to plans
                })
            }
        }
        .navigationBarTitle("List Details", displayMode: .inline)
    }
    
    // convert FruitItem to PlanItem
    private func mapFruitItemsToPlanItems(_ fruitItems: [FruitItem]) -> [PlanItem] {
        return fruitItems.map { fruit in
            PlanItem(name: fruit.name, quantity: fruit.quantity, price: fruit.price)
        }
    }
}


struct ListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ListDetailView(listName: "Sample List")
    }
}

