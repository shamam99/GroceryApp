//
//  PlanDetailSheet.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct PlanDetailSheet: View {
    let plan: Plan

    var body: some View {
        VStack {
            Text("Details for \(plan.title)")
                .font(.headline)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(plan.items, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(item.quantity)x \(item.name)")
                                    .font(.headline)
                                Text("Price: \(String(format: "%.2f", item.price)) SR")
                                    .font(.subheadline)
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
            
            VStack(spacing: 10) {
                Text("Total: \(String(format: "%.2f", plan.total)) SR")
                    .font(.headline)
                    .padding(.top, 20)
                
                Text("Budget: \(String(format: "%.2f", plan.total + plan.saved)) SR")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 10)
            
            Spacer()
            
            Button(action: {
                // Optional: Dismiss the sheet if needed
            }) {
                Text("Done")
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.bottom, 20)
            }
        }
        .padding()
    }
}



struct PlanDetailSheet_Previews: PreviewProvider {
    static var previews: some View {
        PlanDetailSheet(plan: Plan(title: "Sample Plan", items: mockItems100To200, total: 150, saved: 50))
    }
}
