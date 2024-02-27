//
//  Filter+Ext.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 28.02.2024.
//

import UIKit

class ImageFilterService {

    func applyFilter(to inputImage: UIImage, withName filterName: String, parameters: [String: Any] = [:]) -> UIImage? {
        let context = CIContext(options: nil)
        guard let ciInput = CIImage(image: inputImage), let filter = CIFilter(name: filterName, parameters: parameters) else { return nil }
        filter.setValue(ciInput, forKey: kCIInputImageKey)
        for (key, value) in parameters {
            filter.setValue(value, forKey: key)
        }
        
        guard let outputImage = filter.outputImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    func applySepia(to image: UIImage, intensity: Double = 0.8) -> UIImage? {
        applyFilter(to: image, withName: "CISepiaTone", parameters: [kCIInputIntensityKey: intensity])
    }
    
    func applyBlur(to image: UIImage, radius: Double = 10.0) -> UIImage? {
        applyFilter(to: image, withName: "CIGaussianBlur", parameters: [kCIInputRadiusKey: radius])
    }
    
}
