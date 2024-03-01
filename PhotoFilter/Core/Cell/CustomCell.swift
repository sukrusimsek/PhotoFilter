//
//  CustomCell.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 1.03.2024.
//

import UIKit

class CustomCell: UICollectionViewCell {
    let imageForFilter: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .red
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageForFilter)
        
//        NSLayoutConstraint.activate([
//            imageForFilter.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageForFilter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//
//        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
