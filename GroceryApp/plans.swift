//
//  plans.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct Plans: View {
    let minBudget: Double
    let maxBudget: Double
    let items: [PlanItem]
    
    @State private var showConfirmationPopup = false
    @State private var navigateToHome = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        // Generate 3 plans based on the budget
                        ForEach(generatePlans(), id: \.title) { plan in
                            PlanCardView(plan: plan, showConfirmationPopup: $showConfirmationPopup)
                                .frame(width: UIScreen.main.bounds.width - 100)

                                .padding(.vertical)
                        }
                    }
                    .padding(.horizontal, 10)
                   
                }
            }
            
            .navigationBarTitle("Plans", displayMode: .inline)
            .alert(isPresented: $showConfirmationPopup)
            
            {
                Alert(
                    title: Text("Great"),
                    message: Text("Your list is ready now!"),
                    dismissButton: .default(Text("Done"), action: {
                        navigateToHomeView()
                    })
                )
            }
            .padding(.top,-30)
            
        }
        .fullScreenCover(isPresented: $navigateToHome) {
            HomeView()
        }
    }
    
    private func navigateToHomeView() {
        navigateToHome = true
    }
    
    private func generatePlans() -> [Plan] {
        // Plan 1: Budget up to half the max budget
        var plan1Items = [PlanItem]()
        var plan1Total: Double = 0.0
        
        for item in items {
            let itemCost = item.price * Double(item.quantity)
            if plan1Total + itemCost <= maxBudget * 0.5 {
                plan1Items.append(item)
                plan1Total += itemCost
            } else {
                break
            }
        }
        
        let plan1 = Plan(
            title: "\(Int(minBudget))-\(Int(maxBudget * 0.5)) SR",
            items: plan1Items,
            total: plan1Total,
            saved: maxBudget - plan1Total // Save from the user's max budget
        )
        
        // Plan 2: Budget up to 75% of the max budget
        var plan2Items = [PlanItem]()
        var plan2Total: Double = 0.0
        
        for item in items {
            let itemCost = item.price * Double(item.quantity)
            if plan2Total + itemCost <= maxBudget * 0.75 {
                plan2Items.append(item)
                plan2Total += itemCost
            } else {
                break
            }
        }
        
        let plan2 = Plan(
            title: "\(Int(maxBudget * 0.5))-\(Int(maxBudget * 0.75)) SR",
            items: plan2Items,
            total: plan2Total,
            saved: maxBudget - plan2Total // Save from the user's max budget
        )
        
        // Plan 3: Budget up to the full max budget
        var plan3Items = [PlanItem]()
        var plan3Total: Double = 0.0
        
        for item in items {
            let itemCost = item.price * Double(item.quantity)
            if plan3Total + itemCost <= maxBudget {
                plan3Items.append(item)
                plan3Total += itemCost
            } else {
                break
            }
        }
        
        let plan3 = Plan(
            title: "\(Int(maxBudget * 0.75))-\(Int(maxBudget)) SR",
            items: plan3Items,
            total: plan3Total,
            saved: maxBudget - plan3Total // Save from the user's max budget
        )
        
        return [plan1, plan2, plan3]
    }


        
        
}


import SwiftUI

struct PlanCardView: View {
    let plan: Plan
    @Binding var showConfirmationPopup: Bool
    @ObservedObject var planManager = PlanManager.shared
    
    var body: some View {
        VStack(spacing: 10) {
            Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431)
                .frame(height: 30)
            
            Text(plan.title)
                .font(.headline)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(plan.items) { item in
                        HStack {
                            Text("\(item.quantity)x \(item.name)")
                                .font(.body)
                                .padding(.leading, 10)
                            
                            Spacer()
                            
                            Text("\(String(format: "%.2f", item.price))")
                                .font(.body)
                                .padding(.trailing, 10)
                        }
                        .padding(.vertical, 8)
                        .background(Color(.white))
                        .cornerRadius(8)
                        .padding(.horizontal, 8)
                    }
                }
            }
            .frame(height: 300)
            .background(Color.white.opacity(0.9))
            .cornerRadius(10)
            .padding(.horizontal)
            
            VStack(spacing: 8) {
                HStack {
                    Text("Total")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(String(format: "%.2f", plan.total)) SR")
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Saved")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(String(format: "%.2f", plan.saved)) SR")
                        .foregroundColor(.green)
                }
                .frame(height: 30)
                .padding(.horizontal)
            }
            .padding(.top, 10)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal)
            
            Button(action: {
                let selectedPlan = Plan(
                    title: plan.title,
                    items: plan.items.map { PlanItem(name: $0.name, quantity: $0.quantity, price: $0.price) },
                    total: plan.total,
                    saved: plan.saved
                )
                planManager.savePlan(selectedPlan)
                showConfirmationPopup = true
            }) {
                Text("Select")
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.bottom, 20)
            }
        }
        .background(Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431))
        .cornerRadius(15)
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
    }
}
    

    
//    // New function to save the selected plan with all its data
//    private func saveSelectedPlan() {
//        // Construct a full plan with all details
//        let selectedPlan = Plan(
//            title: plan.title,
//            items: plan.items.map { PlanItem(name: $0.name, quantity: $0.quantity, price: $0.price) },
//            total: plan.total,
//            saved: plan.saved
//        )
//        // Save to the PlanManager's savedPlans array
//        planManager.savePlan(selectedPlan)
//    }
//}






struct Plan: Identifiable {
    let id = UUID()
    let title: String
    let items: [PlanItem]
    let total: Double
    let saved: Double
}

struct PlanItem: Identifiable {
    let id = UUID()
    let name: String
    let quantity: Int
    let price: Double
}

let mockItems100To200 = [
    PlanItem(name: "Cucumber 1k", quantity: 1, price: 10.0),
    PlanItem(name: "Tomatoes 1k", quantity: 1, price: 8.0),
    PlanItem(name: "Chocolate Riter", quantity: 2, price: 19.0),
    PlanItem(name: "Ice Cream Vanilla", quantity: 1, price: 20.0),
    PlanItem(name: "Burgat Candy", quantity: 1, price: 5.0)
]

let mockItems200To300 = [
    PlanItem(name: "Item A", quantity: 1, price: 30.0),
    PlanItem(name: "Item B", quantity: 2, price: 25.0)
]

let mockItems300To400 = [
    PlanItem(name: "Item X", quantity: 3, price: 50.0),
    PlanItem(name: "Item Y", quantity: 1, price: 60.0)
]

struct PlanSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Plans(minBudget: 100.0, maxBudget: 500.0, items: mockItems100To200)
    }
}

