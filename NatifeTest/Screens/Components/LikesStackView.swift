//
//  likesStackView.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import UIKit

class LikesStackView: UIStackView {

    private let likesImage: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let imageView = UIImageView(image: image)
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowRadius = 2
        imageView.layer.shadowOpacity = 0.5
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        axis = .horizontal
        spacing = 2
        distribution = .fillProportionally
        
        addArrangedSubview(likesImage)
        addArrangedSubview(likesLabel)
    }

}
