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
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageForFilter)
        
        NSLayoutConstraint.activate([
            imageForFilter.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageForFilter.heightAnchor.constraint(equalTo: contentView.heightAnchor)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell(_ image: UIImage) {
        imageForFilter.image = image
    }
        
}
