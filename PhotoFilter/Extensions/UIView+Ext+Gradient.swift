//
//  UIView+Ext+Gradient.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 1.04.2024.
//

import UIKit

extension UIView {

    func applyGradient(colors: [UIColor] = [.black, .clear], locations: [NSNumber] = [0, 2], startPoint: CGPoint = CGPoint(x: 0.5, y: 1.0), endPoint: CGPoint = CGPoint(x: 0.5, y: 0.0), type: CAGradientLayerType = .axial){
        
        let gradient = CAGradientLayer()
        
        gradient.frame.size = self.frame.size
        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
        gradient.colors = colors.map{ $0.cgColor }
        
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
        
    }
}
