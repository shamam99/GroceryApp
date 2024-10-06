//
//  BudgetEntrySheet.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct BudgetEntrySheet: View {
    @Binding var minBudget: String
    @Binding var maxBudget: String
    var onDone: () -> Void
    
    var body: some View {
        ZStack{
            Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431)
            //                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Price Select")
                    .font(.headline)
                    .padding()
                
                HStack {
                    Text("Min")
                        .font(.subheadline)
                    Spacer()
                    TextField("Enter Min Budget", text: $minBudget)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                }
                .padding()
                
                HStack {
                    Text("Max")
                        .font(.subheadline)
                    Spacer()
                    TextField("Enter Max Budget", text: $maxBudget)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                }
                .padding()
                
                HStack(spacing: 50) {
                    Button(action: {
                        onDone()
                    }) {
                        Text("Cancel")
                            .frame(width: 100, height: 40)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        onDone()
                    }) {
                        Text("Done")
                            .frame(width: 100, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
            }
            
            .padding()
        }
    }
}

struct BudgetEntrySheet_Previews: PreviewProvider {
    static var previews: some View {
        BudgetEntrySheet(minBudget: .constant(""), maxBudget: .constant(""), onDone: {})
    }
}

