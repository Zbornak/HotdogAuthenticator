//
//  UIImage+Resized.swift
//  HotDog
//
//  Created by Mark Strijdom on 26/07/2023.
//

import Foundation
import UIKit
import Vision

extension UIImage {
    func resized() -> UIImage? {
        let size = CGSize(width: 299.0, height: 299.0)
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        if let image = cgImage, let context = UIGraphicsGetCurrentContext() {
            context.draw(image, in: CGRect(origin: .zero, size: size))
            var result = self
            if let resized = context.makeImage() {
                result = UIImage(cgImage: resized)
            }
            UIGraphicsEndImageContext()
            return result
        }
        return nil
    }
}

extension VNClassificationObservation {
    var confidencePercentageString: String {
        let percentage = confidence * 100

        switch percentage {
            case 100.0...:
                return "100%"
            case 10.0..<100.0:
                return String(format: "%2.1f", percentage)
            case 1.0..<10.0:
                return String(format: "%2.1f", percentage)
            case ..<1.0:
                return String(format: "%1.2f", percentage)
            default:
                return String(format: "%2.1f", percentage)
        }
    }
}
