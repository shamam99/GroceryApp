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
            
            
            ZStack/*(spacing: 40)*/ {
                Image("backgroundImage")
                    .resizable()
                    .scaledToFit()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(height:1000)
                ZStack{
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 1300,height: 700)
                        .padding(.top,-200)
                    Image("back")
                        .resizable()
                        .frame(width: 400 ,height: 800)
                }
                .padding(.top,-400)
                    
                
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
                .padding(.top,400)
            }
            .padding()
           
            .navigationBarHidden(true)
            
            .sheet(isPresented: $showSheet) {
                ZStack{
                    Color(red: 0.9529411764705882, green: 0.9490196078431372, blue: 0.9725490196078431)
//                        .ignoresSafeArea()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: 600,height: 1000)
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

