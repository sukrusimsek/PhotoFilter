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
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 16
        blurView.layer.borderColor = UIColor(white: 1, alpha: 0.2).cgColor
        blurView.layer.borderWidth = 1
        blurView.layer.masksToBounds = true
        return blurView
    }()
    let labelForDesc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let buttonForSelectPhoto: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1, alpha: 0.2)
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        return button
    }()
    let labelForButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "   Filter Your Photos"
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    let viewForButtonBack: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0.3)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    let imageForButton: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cellSelectButton")
        return imageView
    }()
//    let viewForAnimation: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .blue
//        return view
//    }()
    override func layoutSubviews() {
        super.layoutSubviews()
//        viewForAnimation.frame = CGRect(x: 0, y: contentView.frame.height * 0.5, width: contentView.frame.width, height: 200)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if let gradientLayer = imageForFilter.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            gradientLayer.removeFromSuperlayer()
        }
        blurView.layer.removeAllAnimations()
        blurLabelForFilterName.layer.removeAllAnimations()
        labelForDesc.layer.removeAllAnimations()
        
        // Öğelerin alfa değerlerini sıfırla
        blurView.alpha = 0.0
        blurLabelForFilterName.alpha = 0.0
        labelForDesc.alpha = 0.0
        
        // Öğeleri başlangıç konumlarına geri getir
        blurView.frame.origin.y = contentView.frame.height - 200
        blurLabelForFilterName.frame.origin.y = contentView.frame.height - 200
        labelForDesc.frame.origin.y = contentView.frame.height - 200
    }
    func applyGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber]? = [0.0, 0.7]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = contentView.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.locations = locations
        imageForFilter.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageForFilter)
        contentView.addSubview(blurView)
        contentView.addSubview(blurLabelForFilterName)
        contentView.backgroundColor = UIColor(red: 30, green: 30, blue: 30)
//        contentView.addSubview(viewForAnimation)
        
        blurLabelForFilterName.layer.zPosition = 1
        imageForFilter.addSubview(labelForDesc)
        contentView.addSubview(buttonForSelectPhoto)
        imageForFilter.addSubview(labelForButton)
        imageForFilter.addSubview(viewForButtonBack)
        imageForFilter.addSubview(imageForButton)
        
        NSLayoutConstraint.activate([

            imageForFilter.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageForFilter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageForFilter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageForFilter.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -212),
            
            blurView.topAnchor.constraint(equalTo: blurLabelForFilterName.topAnchor, constant: -10),
            blurView.leadingAnchor.constraint(equalTo: blurLabelForFilterName.leadingAnchor, constant: -10),
            blurView.trailingAnchor.constraint(equalTo: blurLabelForFilterName.trailingAnchor, constant: 10),
            blurView.bottomAnchor.constraint(equalTo: blurLabelForFilterName.bottomAnchor,constant: 10),

            blurLabelForFilterName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            blurLabelForFilterName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            labelForDesc.topAnchor.constraint(equalTo: blurView.bottomAnchor, constant: 10),
            labelForDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            labelForDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            buttonForSelectPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
            buttonForSelectPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonForSelectPhoto.heightAnchor.constraint(equalToConstant: 56),
            buttonForSelectPhoto.widthAnchor.constraint(equalToConstant: 212),
            
            
            labelForButton.leadingAnchor.constraint(equalTo: buttonForSelectPhoto.leadingAnchor, constant: 5),
            labelForButton.centerYAnchor.constraint(equalTo: buttonForSelectPhoto.centerYAnchor),
            
            viewForButtonBack.trailingAnchor.constraint(equalTo: buttonForSelectPhoto.trailingAnchor, constant: -10),
            viewForButtonBack.centerYAnchor.constraint(equalTo: buttonForSelectPhoto.centerYAnchor),
            viewForButtonBack.heightAnchor.constraint(equalToConstant: 34),
            viewForButtonBack.widthAnchor.constraint(equalToConstant: 34),
            
            imageForButton.centerXAnchor.constraint(equalTo: viewForButtonBack.centerXAnchor),
            imageForButton.centerYAnchor.constraint(equalTo: viewForButtonBack.centerYAnchor),
            imageForButton.heightAnchor.constraint(equalToConstant: 14),
            imageForButton.widthAnchor.constraint(equalToConstant: 21),
            
        ])
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func animateIn() {
        blurLabelForFilterName.alpha = 0.0
        blurView.alpha = 0.0
        labelForDesc.alpha = 0.0
        blurView.frame.origin.y = contentView.frame.height - 220
        blurLabelForFilterName.frame.origin.y = contentView.frame.height - 220
        labelForDesc.frame.origin.y = contentView.frame.height - 220
        
        
        UIView.animate(withDuration: 1.5) {
            self.blurView.frame.origin.y = self.contentView.frame.height * 0.5
            self.blurLabelForFilterName.frame.origin.y = self.blurView.frame.midY
            self.labelForDesc.frame.origin.y = self.blurView.frame.maxY + 10
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.3, options: [.curveEaseOut], animations: {
            self.blurLabelForFilterName.alpha = 1.0
            self.blurView.alpha = 1.0
            self.labelForDesc.alpha = 1.0
        }, completion: nil)
    }
    
    func animateOut() {
        UIView.animate(withDuration: 1.5) {
            self.blurView.frame.origin.y = -self.contentView.frame.height * 0.3
            self.blurLabelForFilterName.frame.origin.y = self.blurView.frame.midY
            self.labelForDesc.frame.origin.y = self.blurView.frame.maxY + 10
        }
        UIView.animate(withDuration: 1.5, delay: 0.3, options: [.curveEaseOut], animations: {
            self.blurLabelForFilterName.alpha = 0.0
            self.blurView.alpha = 0.0
            self.labelForDesc.alpha = 0.0
        }, completion: nil)
    }

    
//    func animateOut() {
//        UIView.animate(withDuration: 1.5) {
//            self.blurView.frame.origin.y = self.contentView.frame.height * 0.3
//            self.blurLabelForFilterName.frame.origin.y = self.blurView.frame.midY
//            self.labelForDesc.frame.origin.y = self.blurView.frame.maxY + 10
//        }
//        UIView.animate(withDuration: 1.5, delay: 0.3, options: [.curveEaseOut], animations: {
//            self.blurLabelForFilterName.alpha = 0.0
//            self.blurView.alpha = 0.0
//            self.labelForDesc.alpha = 0.0
//        }, completion: nil)
//    }
    
//    func animateOut() {
//        UIView.animate(withDuration: 1.5) {
//            self.blurView.frame.origin.y = self.contentView.frame.height * 0.3
//            self.blurLabelForFilterName.frame.origin.y = self.contentView.frame.height * 0.3
//            self.labelForDesc.frame.origin.y = self.blurView.frame.maxY + 10
//            
//            
//            
//        }
//    }
    
    

    
}

