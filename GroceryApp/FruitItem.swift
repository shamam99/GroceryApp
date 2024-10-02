//
//  FruitItem.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import Foundation

struct FruitItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var imageName: String
    var price: Double
    var quantity: Int = 0
}
