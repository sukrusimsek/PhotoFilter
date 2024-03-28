//
//  FirstHomeCell.swift
//  PhotoFilter
//
//  Created by Şükrü Şimşek on 28.03.2024.
//

import UIKit

class FirstHomeCell: UICollectionViewCell {
    
    let imageForFilter: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let blurLabelForFilterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .white
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
    let labelForDesc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let buttonForSelectPhoto: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1, alpha: 0.2)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()
    let labelForButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "Filter Your Photos"
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    let imageForButton: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cellSelectButton")
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 21, height: 14)
        imageView.layer.cornerRadius = 7
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageForFilter)
        contentView.addSubview(blurView)
        contentView.addSubview(blurLabelForFilterName)
        blurLabelForFilterName.layer.zPosition = 1
        imageForFilter.addSubview(labelForDesc)
        imageForFilter.addSubview(buttonForSelectPhoto)
        buttonForSelectPhoto.addSubview(labelForButton)
        buttonForSelectPhoto.addSubview(imageForButton)
        
        NSLayoutConstraint.activate([
            imageForFilter.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageForFilter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageForFilter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageForFilter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            blurView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            blurView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            blurLabelForFilterName.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            blurLabelForFilterName.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            
            labelForDesc.topAnchor.constraint(equalTo: blurView.bottomAnchor, constant: 10),
            labelForDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelForDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            buttonForSelectPhoto.topAnchor.constraint(equalTo: labelForDesc.bottomAnchor, constant: 30),
            buttonForSelectPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonForSelectPhoto.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            buttonForSelectPhoto.heightAnchor.constraint(equalToConstant: 70),
            
            labelForButton.leadingAnchor.constraint(equalTo: buttonForSelectPhoto.leadingAnchor, constant: 5),
            labelForButton.centerYAnchor.constraint(equalTo: buttonForSelectPhoto.centerYAnchor),
            
            imageForButton.leadingAnchor.constraint(equalTo: labelForButton.trailingAnchor, constant: 5),
            imageForButton.centerYAnchor.constraint(equalTo: buttonForSelectPhoto.centerYAnchor),
            

            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
