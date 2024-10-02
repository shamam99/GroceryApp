//
//  MyListView.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct MyListView: View {
    @ObservedObject var basketManager = BasketManager.shared
    @Binding var navigateToHome: Bool
    
    var body: some View {
        VStack {
            Text("Your Lists")
                .font(.largeTitle)
                .padding(.top, 20)
            
            ScrollView {
                ForEach(basketManager.createdLists, id: \.name) { createdList in
                    NavigationLink(destination: ListDetailView(listName: createdList.name)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(createdList.name)
                                    .font(.headline)
                                Text("\(formattedDate(Date()))")
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
            
            Spacer()
        }
        .navigationBarTitle("Your Lists", displayMode: .inline)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM / yyyy"
        return formatter.string(from: date)
    }
}

// Preview for MyListView
struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView(navigateToHome: .constant(false))
    }
}





