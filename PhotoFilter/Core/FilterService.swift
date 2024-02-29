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
    func applyColorInvert(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIColorInvert")
    }
    func applyMonochrom(to image: UIImage, color: CIColor = (CIColor(red: 1, green: 0, blue: 0)), intensity: Double = 1) -> UIImage? {
        applyFilter(to: image, withName: "CIColorMonochrome", parameters: [kCIInputIntensityKey : intensity])
    }
    func applyColorControl(to image: UIImage, brightness: Double = -0.4, contrast: Double = 1.0, saturation: Double = 1.0) -> UIImage? {
        applyFilter(to: image, withName: "CIColorControls", parameters: [kCIInputBrightnessKey : brightness, kCIInputContrastKey: contrast, kCIInputSaturationKey: saturation])
    }
    func applyBokehBlur(to image: UIImage, ringSize: Double = 0.1, ringAmount: Double = 0, softness: Double = 1, radius: Int = 20) -> UIImage? {
        applyFilter(to: image, withName: "CIBokehBlur", parameters: ["inputRingSize" : ringSize,
                                                                     "inputRingAmount" : ringAmount,
                                                                     "inputSoftness" : softness,
                                                                     kCIInputRadiusKey : radius] )
    }
    func applyVibrance(to image: UIImage, amount: Double = 2.0) -> UIImage? {
        applyFilter(to: image, withName: "CIVibrance", parameters: [kCIInputAmountKey : amount])
    }
    func applyCircularScreen(to image: UIImage, center: CGPoint = CGPoint(x: 2250, y: 1512), sharpness: Float = 0.70, width: Float = 35.0) -> UIImage? {
        let centerVector = CIVector(x: center.x, y: center.y)
        return applyFilter(to: image, withName: "CICircularScreen", parameters: [kCIInputCenterKey : centerVector,
                                                                       kCIInputSharpnessKey : sharpness,
                                                                           kCIInputWidthKey : width])
    }
    func applyToneCurve(to image: UIImage, point0: CGPoint = CGPoint(x: 0, y: 0), point1: CGPoint = CGPoint(x: 0.22, y: 0.25), point2: CGPoint = CGPoint(x: 0.4, y: 0.5), point3: CGPoint = CGPoint(x: 0.65, y: 0.75), point4: CGPoint = CGPoint(x: 1, y: 1)) -> UIImage? {
        let inputPoint0 = CIVector(cgPoint: point0)
        let inputPoint1 = CIVector(cgPoint: point1)
        let inputPoint2 = CIVector(cgPoint: point2)
        let inputPoint3 = CIVector(cgPoint: point3)
        let inputPoint4 = CIVector(cgPoint: point4)
        return applyFilter(to: image, withName: "CIToneCurve", parameters: ["inputPoint0" : inputPoint0,
                    "inputPoint1" : inputPoint1,
                    "inputPoint2" : inputPoint2,
                    "inputPoint3" : inputPoint3,
                    "inputPoint4" : inputPoint4])
    }
    func applyTemperatureAndTint(to image: UIImage, neutral: CIVector = CIVector(x: 11500, y: 10), targetNeutral: CIVector = CIVector(x: 4000, y: 0)) -> UIImage? {
        applyFilter(to: image, withName: "CITemperatureAndTint", parameters: ["inputNeutral" : neutral, "inputTargetNeutral" : targetNeutral])
    }
    func applySRGBToneCurveToLinear(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CISRGBToneCurveToLinear")
    }
    func applyPixellate(to image: UIImage, center: CGPoint = CGPoint(x: 150, y: 150), scale: Float = 30)-> UIImage? {
        let centerVector = CIVector(x: center.x, y: center.y)
        return applyFilter(to: image, withName: "CIPixellate", parameters: [kCIInputCenterKey : centerVector, kCIInputScaleKey : scale])
    }
    func applyPhotoEffectTransfer(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIPhotoEffectTransfer")
    }
    func applyPhotoEffectNoir(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIPhotoEffectNoir")
    }
    func applyPhotoEffectMono(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIPhotoEffectMono")
    }
    func applyPhotoEffectInstant(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIPhotoEffectInstant")
    }
    func applyPhotoEffectFade(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIPhotoEffectFade")
    }
    func applyNoiseReduction(to image: UIImage, noiseLevel: Float = 0.2, sharpness: Float = 0.4)-> UIImage? {
        applyFilter(to: image, withName: "CINoiseReduction", parameters: ["inputNoiseLevel" : noiseLevel, kCIInputSharpnessKey: sharpness])
    }
    func applyMotionBlur(to image: UIImage, angle: Float = 0, radius: Float = 20)-> UIImage? {
        applyFilter(to: image, withName: "CIMotionBlur", parameters: [kCIInputAngleKey : angle, kCIInputRadiusKey: radius])
    }
    func applyMinimumComponent(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIMinimumComponent")
    }
    func applyMedian(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIMedianFilter")
    }
    func applyMaskToAlpha(to image: UIImage)-> UIImage? {
        applyFilter(to: image, withName: "CIMaskToAlpha")
    }
    
}
