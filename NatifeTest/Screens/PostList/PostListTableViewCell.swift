//
//  PostListTableViewCell.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import Foundation
import UIKit

class PostListTableViewCell: UITableViewCell {
    
    static let identifier = "PostsTableViewCell"
    
    weak var tableView: UITableView?
    
    private var showFullTitle: Bool = true
    
    var post: Post? {
        willSet(newPost) {
            guard let post = newPost else { return }
            
            titleLabel.text = post.title
            dateStackView.dateLabel.text = post.daysAgo()
            likesStackView.likesLabel.text = "\(post.likesCount)"
            
            checkMultilineLabel(text: titleLabel.text ?? "")
        }
    }
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        view.backgroundColor = ColorTheme.contentBlock
        
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 2
        label.text = ""
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Expand", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = ColorTheme.accent
        button.layer.cornerRadius = 10
        button.isHidden = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.layer.shadowRadius = 10
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    private lazy var likesStackView = LikesStackView()
    private lazy var dateStackView = DateStackView()
    
    private lazy var horizontalStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [likesStackView, spacer, dateStackView])
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, horizontalStackView, button])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public func
    
    func checkMultilineLabel(text: String) {
         // max symbols - 55
         if text.count > 55 {
             button.isHidden = false
         } else {
             button.isHidden = true
         }
    }
    
    // MARK: - Private func
    
    @objc private func buttonTapped() {
        if showFullTitle {
            titleLabel.numberOfLines = 0
            button.setTitle("Collapse", for: .normal)
            showFullTitle = false
        } else {
            titleLabel.numberOfLines = 2
            button.setTitle("Expand", for: .normal)
            showFullTitle = true
        }
        
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    // MARK: Make UI
    
    private func configureUI() {
        contentView.backgroundColor = ColorTheme.background
        
        contentView.addSubview(customView)
        customView.addSubview(mainStackView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let HorizontalPadding: CGFloat = 20
        let VerticalPadding: CGFloat = 15
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HorizontalPadding),
            customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: VerticalPadding),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -VerticalPadding),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HorizontalPadding),
            
            mainStackView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: HorizontalPadding),
            mainStackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: VerticalPadding),
            mainStackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -VerticalPadding),
            mainStackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -HorizontalPadding),
            
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
}
