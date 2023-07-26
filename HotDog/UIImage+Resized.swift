//
//  UIImage+Resized.swift
//  HotDog
//
//  Created by Mark Strijdom on 26/07/2023.
//

import Foundation
import UIKit

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
