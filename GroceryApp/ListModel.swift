//
//  ListModel.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import Foundation

struct CreatedList: Identifiable {
    let id = UUID()
    var name: String
    var dateCreated: Date
}

