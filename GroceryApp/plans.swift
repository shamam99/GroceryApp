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
        let totalCost = items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        
        let plan1 = Plan(
            title: "\(Int(minBudget))-\(Int(maxBudget * 0.5)) SR",
            items: items.filter { $0.price * Double($0.quantity) <= maxBudget * 0.5 },
            total: min(maxBudget * 0.5, totalCost),
            saved: maxBudget * 0.5 - totalCost
        )
        
        let plan2 = Plan(
            title: "\(Int(maxBudget * 0.5))-\(Int(maxBudget * 0.75)) SR",
            items: items.filter { $0.price * Double($0.quantity) <= maxBudget * 0.75 },
            total: min(maxBudget * 0.75, totalCost),
            saved: maxBudget * 0.75 - totalCost
        )
        
        let plan3 = Plan(
            title: "\(Int(maxBudget * 0.75))-\(Int(maxBudget)) SR",
            items: items.filter { $0.price * Double($0.quantity) <= maxBudget },
            total: min(maxBudget, totalCost),
            saved: maxBudget - totalCost
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
        ZStack{
            VStack(spacing: 10) {
                Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431)
                    .ignoresSafeArea()
                    .frame(height: 30)
                Text(plan.title)
                    .font(.headline)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .padding(.top,10)
                    .background(Color.white)
                //                .shadow(radius: 30)
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
                            //                        .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 0, y: 1)
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
                .padding(.top,10)
                //            .padding(.all,0)
                .background(Color.white)
                //            .shadow(radius: 20)
                .cornerRadius(8)
                .padding(.horizontal)
                
                Button(action: {
                    // Save the full plan details in PlanManager
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
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .background(Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431))
//        .ignoresSafeArea()
//        .frame(height: 800)
       
        .cornerRadius(15)
//        .shadow(color: Color.blue.opacity(0.2), radius: 8, x: 0, y: 4)
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

