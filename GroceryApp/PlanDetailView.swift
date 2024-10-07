//
//  PlanDetailSheet.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct PlanDetailView: View {
    let plan: Plan

    var body: some View {
        ZStack {
            Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431)
                .edgesIgnoringSafeArea(.all)
            
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
                            .background(Color(.white))
                            .cornerRadius(10)
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
            }
            .padding()
        }
        .navigationBarTitle("Plan Details", displayMode: .inline)
    }
}


struct PlanDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlanDetailView(plan: Plan(title: "Sample Plan", items: mockItems100To200, total: 150, saved: 50))
    }
}
