//
//  DateStackView.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import UIKit

class DateStackView: UIStackView {
    
    private let dateImage: UIImageView = {
        let image = UIImage(systemName: "clock.arrow.circlepath")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.theme.secondaryText
        
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowRadius = 2
        imageView.layer.shadowOpacity = 0.5
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.theme.secondaryText
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
        
        addArrangedSubview(dateImage)
        addArrangedSubview(dateLabel)
    }
    
}

