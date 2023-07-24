//
//  ContentView.swift
//  HotDog
//
//  Created by Mark Strijdom on 24/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isHotdog = false
    
    var body: some View {
        VStack {
            VStack {
                Text("🌭")
                    .font(.largeTitle)
                Text("Hot Dog Authenticator v 1.1")
                    .font(.title)
                    .fontWeight(.bold)
                Text("© TechDyne Global Propietary Systems Ltd.")
                    .font(.footnote)
            }
            
            Spacer()
            
            Button {
                // select image
            } label: {
                Image(systemName: "plus.viewfinder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            Spacer()
            
            Text(isHotdog ? "This is a Hot Dog" : "This is not a Hot Dog")
                .fontWeight(.bold)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
