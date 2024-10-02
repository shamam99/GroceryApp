//
//  SavedPlansView.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct SavedPlansView: View {
    @ObservedObject var planManager = PlanManager.shared
    @State private var showPlanDetail = false
    @State private var selectedPlan: Plan?

    var body: some View {
        VStack {
            Text("Saved Plans")
                .font(.largeTitle)
                .padding(.top, 20)
            
            ScrollView {
                ForEach(planManager.savedPlans, id: \.id) { plan in
                    Button(action: {
                        selectedPlan = plan // Set selected plan
                        showPlanDetail = true // Show the plan detail sheet
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(plan.title)
                                    .font(.headline)
                                Text("Total: \(String(format: "%.2f", plan.total)) SR")
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
            }
            
            Spacer()
        }
        .sheet(isPresented: $showPlanDetail) {
            if let unwrappedPlan = selectedPlan {
                PlanDetailSheet(plan: unwrappedPlan)
            }
        }
        .navigationBarTitle("Saved Plans", displayMode: .inline)
    }
}




struct SavedPlansView_Previews: PreviewProvider {
    static var previews: some View {
        SavedPlansView()
    }
}

