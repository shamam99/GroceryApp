//
//  HomeView.swift
//  GroceryApp
//
//  Created by Shamam Alkafri on 02/10/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var showSheet = false
    @State private var listName = ""
    @State private var navigateToCategories = false
    @State private var navigateToMyList = false
    @State private var navigateToHome = false
    @State private var navigateToSavedPlans = false
    

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Image("backgroundImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
                VStack(spacing: 20) {
                    NavigationLink(destination: MyListView(navigateToHome: $navigateToHome), isActive: $navigateToMyList) {
                        Text("My List")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        showSheet = true
                    }) {
                        Text("New List")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SavedPlansView(), isActive: $navigateToSavedPlans) {
                        Text("Saved Plans")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationBarHidden(true)
            
            .sheet(isPresented: $showSheet) {
                VStack(spacing: 20) {
                    Text("List Name")
                        .font(.title)
                        .padding(.top, 20)
                    
                    Text("Please enter a name for your list!")
                        .padding(.bottom, 20)
                    
                    TextField("List Name", text: $listName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 300)
                    
                    HStack(spacing: 40) {
                        Button("Cancel") {
                            showSheet = false
                        }
                        .frame(width: 100, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Button("Next") {
                            showSheet = false
                            navigateToCategories = true
                        }
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        // Disable the button if the name is empty
                        .disabled(listName.isEmpty)
                    }
                    .padding(.bottom, 20)
                }
                .padding()
            }

            .navigationDestination(isPresented: $navigateToCategories) {
                ItemSelectionView(navigateToHome: $navigateToHome, listName: listName)
            }
        }
        .onAppear {
            navigateToCategories = false
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

