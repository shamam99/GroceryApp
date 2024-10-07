//
//  ContentView.swift
//  market
//
//  Created by Shamam Alkafri on 29/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            if isActive {
                HomeView()
            } else {
                Color.blue
                    .ignoresSafeArea()
                
                Image("logo1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

