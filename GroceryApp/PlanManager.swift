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
        savedPlans.append(plan)
        print("Saved Plan Details:", plan)
    }
}


