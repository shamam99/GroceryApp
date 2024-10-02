//
//  BasketManager.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

class BasketManager: ObservableObject {
    static let shared = BasketManager()
    
    @Published var basketItems: [FruitItem] = []
    @Published var createdLists: [(name: String, items: [FruitItem])] = []
    
    func updateBasket(fruit: FruitItem, quantity: Int) {
        if let index = basketItems.firstIndex(where: { $0.id == fruit.id }) {
            if quantity == 0 {
                basketItems.remove(at: index)
            } else {
                basketItems[index].quantity = quantity
            }
        } else if quantity > 0 {
            var newFruit = fruit
            newFruit.quantity = quantity
            basketItems.append(newFruit)
        }
    }
    
    func getQuantity(for fruit: FruitItem) -> Int {
        return basketItems.first(where: { $0.id == fruit.id })?.quantity ?? 0
    }
    
    var totalCount: Int {
        return basketItems.reduce(0) { $0 + $1.quantity }
    }
    
    func createList(name: String) {
        createdLists.append((name: name, items: basketItems))
        basketItems.removeAll()
    }
}

