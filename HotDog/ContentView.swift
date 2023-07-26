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
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var resultsText = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("Hot Dog Authenticator")
                    .font(.title)
                    .fontWeight(.bold)
                Text("v1.1 XE α")
                    .font(.title)
                Text("© TechDyne Global Propietary Systems Ltd.")
                    .font(.footnote)
            }
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .fill(.secondary)
                    .frame(width: 299, height: 299)
                
                VStack {
                    Image(systemName: "photo")
                    Text("Select an image")
                }
                .foregroundColor(.white)
                
                image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 299, height: 299)
                    .rotationEffect(.degrees(180))
                    .scaleEffect(x: -1, y: 1)
            }
            .onTapGesture {
                showingImagePicker = true
            }
            
            Spacer()
            
            HStack {
//                ZStack {
//                    Text("🌭")
//                    Text(isHotdog ? "" : "❌")
//                }
//                .font(.largeTitle)
                
                Text(resultsText)
                    .fontWeight(.bold)
            }
            
            Button {
                calculateResult()
            } label: {
                Label("Analyze", systemImage: "magnifyingglass")
            }
            .disabled(image == nil)
            .padding()
            .buttonStyle(.borderedProminent)
            .foregroundColor(.black)
            .tint(.mint)
        }
        .padding()
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage?.resized() else {
            return
        }
        
        image = Image(uiImage: inputImage)
    }
    
    func calculateResult() {
        do {
            let config = MLModelConfiguration()
            let model = try VNCoreMLModel(for: HotDogClassifier(configuration: config).model)
            let request = VNCoreMLRequest(model: model, completionHandler: results)
            let ciImage = CIImage(image: inputImage!)
            let handler = VNImageRequestHandler(cgImage: ciImage!.cgImage!)
            try handler.perform([request])

            func results(request: VNRequest, error: Error?) {
                guard let results = request.results as? [VNClassificationObservation] else {
                    fatalError("Fatal error.")
                }

                for classification in results {
                    print(classification.identifier, classification.confidence)
                    // classification.confidence.0
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
