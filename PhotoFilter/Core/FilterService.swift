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
    func applyToneCurve(to image: UIImage, point0: CIVector = CIVector(x: 0, y: 0), point1: CIVector = CIVector(x: 0.22, y: 0.25), point2: CIVector = CIVector(x: 0.4, y: 0.5), point3: CIVector = CIVector(x: 0.65, y: 0.75), point4: CIVector = CIVector(x: 1, y: 1)) -> UIImage? {

        return applyFilter(to: image, withName: "CIToneCurve", parameters: ["inputPoint0" : point0,
                    "inputPoint1" : point1,
                    "inputPoint2" : point2,
                    "inputPoint3" : point3,
                    "inputPoint4" : point4])
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
//    func applyMaskToAlpha(to image: UIImage)-> UIImage? {
//        applyFilter(to: image, withName: "CIMaskToAlpha")
//    }
    func applylinearToSRGBToneCurve(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CILinearToSRGBToneCurve")
    }
    func applylineOverlay(to image: UIImage, nrNoiseLevel: Float = 0.07, nrSharpness: Float = 0.71, edgeIntensity: Float = 1, threshold: Float = 0.1, constrant: Float = 50.00)-> UIImage? {
        applyFilter(to: image, withName: "CILineOverlay", parameters: ["inputnrNoisLevel" : nrNoiseLevel,
                                                                       kCIInputSharpnessKey: nrSharpness,
                                                                       kCIInputIntensityKey: edgeIntensity,
                                                                       "inputThresold": threshold,
                                                                       kCIInputContrastKey: constrant])
    }
    
    func applyHueAdjuc(to image: UIImage, angle: Float = 5)-> UIImage? {
        applyFilter(to: image, withName: "CIHueAdjust", parameters: [kCIInputAngleKey : angle])
    }
    func applyHatchedScreen(to image: UIImage, center: CIVector = CIVector(x: 2016, y: 1512), angle: Float = 10, width: Float = 35, sharpness: Float = 0.7) -> UIImage? {
        applyFilter(to: image, withName: "CIHatchedScreen", parameters: [kCIInputCenterKey : center,
                                                                           kCIInputAngleKey: angle,
                                                                           kCIInputWidthKey: width,
                                                                       kCIInputSharpnessKey: sharpness])
    }
    func applyHexagonalPixellate(to image: UIImage, center: CIVector = CIVector(x: 2016, y: 1512), scale: Float = 50)-> UIImage? {
        applyFilter(to: image, withName: "CIHexagonalPixellate", parameters: [kCIInputCenterKey : center,
                                                                                kCIInputScaleKey: scale])
    }
    func applyGammaAdjust(to image: UIImage, power: Float = 4) -> UIImage? {
        applyFilter(to: image, withName: "CIGammaAdjust", parameters: ["inputPower" : power])
    }
    func applyFalseColor(to image: UIImage, color0: CIColor = CIColor(red: 1, green: 1, blue: 0), color1: CIColor = CIColor(red: 0, green: 0, blue: 1)) -> UIImage? {
        applyFilter(to: image, withName: "CIFalseColor")
    }
    func applyEdgeWork(to image: UIImage, radius: Float = 4)-> UIImage? {
        applyFilter(to: image, withName: "CIEdgeWork", parameters: [kCIInputRadiusKey : radius])
    }
    func applyDocumentEnhancer(to image: UIImage, amount: Float = 4)-> UIImage? {
        applyFilter(to: image, withName: "CIDocumentEnhancer", parameters: [kCIInputAmountKey : amount])
    }
    func applyDotScreen(to image: UIImage, angle: Float = 0, center: CIVector = CIVector(x: 2016, y: 1512), width: Float = 25, sharpness: Float = 0.7)-> UIImage? {
        applyFilter(to: image, withName: "CIDotScreen", parameters: [kCIInputAngleKey : angle,
                                                                     kCIInputCenterKey: center,
                                                                      kCIInputWidthKey: width,
                                                                  kCIInputSharpnessKey: sharpness])
    }
    func applyDither(to image: UIImage, intensity: Float = 0.4 )-> UIImage? {
        applyFilter(to: image, withName: "CIDither", parameters: [kCIInputIntensityKey : intensity])
    }
    func applyDiscBlur(to image: UIImage, radius: Float = 8)-> UIImage? {
        applyFilter(to: image, withName: "CIDiscBlur", parameters: [kCIInputRadiusKey : radius])
    }
//    func applyDepthToDisparity(to image: UIImage)-> UIImage? {
//        applyFilter(to: image, withName: "CIDepthToDisparity")
//    }
    func applyDepthOfField(to image: UIImage, radius: Float = 5, point0: CIVector = CIVector(x: 2349, y: 846), point1: CIVector = CIVector(x: 571, y: 3121), unSharpMaskRadius: Float = 7, unSharpMaskIntensity: Float = 10)-> UIImage? {
        applyFilter(to: image, withName: "CIDepthOfField", parameters: [kCIInputRadiusKey : radius,
                                                                        "inputPoint0": point0,
                                                                        "inputPoint1": point1])
    }
    func applyBloomFilter(to image: UIImage, radius: Float = 10, intensity: Float = 1)-> UIImage? {
        applyFilter(to: image, withName: "CIBloom", parameters: [kCIInputRadiusKey : radius,
                                                               kCIInputIntensityKey: intensity])
    }
    func applyCrystallize(to image: UIImage, radius: Float = 50, center: CIVector = CIVector(x: 2016, y: 1512)) -> UIImage? {
        applyFilter(to: image, withName: "CICrystallize", parameters: [kCIInputRadiusKey : radius,
                                                                        kCIInputCenterKey: center])
    }
    func applyConvolution3x3(to image: UIImage, weights: CIVector = CIVector(values: [
        0, -2, 0,
        -2, 9, -2,
        0, -2, 0
    ], count: 9), bias: Float = 0)-> UIImage? {
        applyFilter(to: image, withName: "CIConvolution3X3", parameters: [kCIInputWeightsKey : weights,
                                                                           kCIInputBiasKey: bias])
    }
    func applyConvolution7x7(to image: UIImage, weights: CIVector = CIVector(values: [
        0, 0, -1, -1, -1, 0, 0,
        0, -1, -3, -3, -3, -1, 0,
        -1, -3, 0, 7, 0, -3, -1,
        -1, -3, 7, 25, 7, -3, -1,
        -1, -3, 0, 7, 0, -3, -1,
        0, -1, -3, -3, -3, -1, 0,
        0, 0, -1, -1, -1, 0, 0
    ], count: 49), bias: Float = 0)-> UIImage? {
        applyFilter(to: image, withName: "CIConvolution7X7", parameters: [kCIInputWeightsKey : weights,
                                                                           kCIInputBiasKey: bias])
    }
    func applyComicEffect(to image: UIImage) -> UIImage? {
        applyFilter(to: image, withName: "CIComicEffect")
    }
    func applyBoxBlur(to image: UIImage, radius: Float = 10) -> UIImage? {
        applyFilter(to: image, withName: "CIBoxBlur", parameters: [kCIInputRadiusKey : radius])
    }
}
