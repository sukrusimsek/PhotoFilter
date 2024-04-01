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
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        return image
    }()
    let labelForFilterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .black
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 5
        blurView.layer.masksToBounds = true
        return blurView
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageForFilter)
        contentView.addSubview(blurView)
        contentView.addSubview(labelForFilterName)
        labelForFilterName.layer.zPosition = 1
        NSLayoutConstraint.activate([
            imageForFilter.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageForFilter.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            blurView.topAnchor.constraint(equalTo: labelForFilterName.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: labelForFilterName.leadingAnchor, constant: -3),
            blurView.trailingAnchor.constraint(equalTo: labelForFilterName.trailingAnchor, constant: 3),
            blurView.bottomAnchor.constraint(equalTo: labelForFilterName.bottomAnchor),
            
            labelForFilterName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            labelForFilterName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell(_ image: UIImage, text: String) {
        imageForFilter.image = image
        labelForFilterName.text = text
    }
        
}
