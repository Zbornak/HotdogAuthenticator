//
//  ContentView.swift
//  HotDog
//
//  Created by Mark Strijdom on 24/07/2023.
//

import CoreImage
import CoreML
import SwiftUI
import UIKit
import Vision

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
            
            ZStack {
                Rectangle()
                    .fill(.secondary)
                
                Image(systemName: "photo")
                    .foregroundColor(.white)
                
                input?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 299, height: 299)
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
            
            Text("")
        }
        .padding()
    }
    
    func calculateResult() {
        do {
            let config = MLModelConfiguration()
            let model = try VNCoreMLModel(for: HotDogClassifier(configuration: config).model)
            let request = VNCoreMLRequest(model: model, completionHandler: results)
            let handler = VNImageRequestHandler(url: input)
            try handler.perform([request])
            
            func results(request: VNRequest, error: Error?) {
                guard let results = request.results as? [VNClassificationObservation] else {
                    fatalError("Fatal error.")
                }
                
                for classification in results {
                    print(classification.identifier, classification.confidence)
                }
            }
           
        } catch {
            print("Failed with error: \(error.localizedDescription).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
