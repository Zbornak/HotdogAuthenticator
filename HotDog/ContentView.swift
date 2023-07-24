//
//  ContentView.swift
//  HotDog
//
//  Created by Mark Strijdom on 24/07/2023.
//

import CoreML
import SwiftUI
import UIKit

struct ContentView: View {
    @State private var isHotdog = false
    @State private var input: Image?
    
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
                // do stuff
            } label: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            Spacer()
            
            HStack {
                ZStack {
                    Text("🌭")
                    Text(isHotdog ? "" : "❌")
                }
                .font(.title)
                
                Text(isHotdog ? "This is a Hot Dog" : "This is not a Hot Dog")
                    .fontWeight(.bold)
            }
        }
        .padding()
    }
    
    func calculateResult(image: Image?) {
        do {
            let config = MLModelConfiguration()
            let model = try HotDogClassifier(configuration: config)
            let input = HotDogClassifierInput(image: <#T##CVPixelBuffer#>)
            let output = try model.prediction(input: input)
            let text = output.classLabel
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
