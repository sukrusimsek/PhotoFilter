//
//  UIView+Ext+Gradient.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 1.04.2024.
//

import UIKit

extension UIView {
//    func applyGradient(colors: [UIColor] = [UIColor(white: 1, alpha: 0.2), .clear],  startPoint: CGPoint = CGPoint(x: 0.5, y: 1.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),locations: [NSNumber] = [0, 2], type: CAGradientLayerType = .axial){
//        
//        let gradient = CAGradientLayer()
//        
//        gradient.frame.size = self.frame.size
//        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
//        gradient.colors = colors.map{ $0.cgColor }
//        
//        gradient.locations = locations
//        gradient.startPoint = startPoint
//        gradient.endPoint = endPoint
//        self.layer.insertSublayer(gradient, at: 0)
//        
//    }
//    
    func applyGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber]? = [0.0,0.7]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        if let buttonLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            buttonLayer.removeFromSuperlayer()
        }
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
