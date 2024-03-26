//
//  UIBarButtonItemSize+Ext.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 26.03.2024.
//

import UIKit

extension UIBarButtonItem {

    static func menuButton(_ target: Any?, action: Selector, imageName: String, height: Int = 24, width: Int = 24) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true

        return menuBarItem
    }
}

