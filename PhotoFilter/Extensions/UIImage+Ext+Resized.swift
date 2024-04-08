//
//  UIImage+Ext+Resized.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 8.04.2024.
//

import UIKit

extension UIImage {
    func resizedImage(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
    }
}
