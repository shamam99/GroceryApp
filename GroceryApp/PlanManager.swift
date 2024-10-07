//
//  PlanManager.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI
import Combine

class PlanManager: ObservableObject {
    static let shared = PlanManager()
    @Published private(set) var savedPlans: [Plan] = []

    func savePlan(_ plan: Plan) {
        // Debug: Print the plan being saved
        print("Saving Plan: \(plan)")
        
        savedPlans.append(plan)
        print("Current Saved Plans: \(savedPlans)")
    }
}



