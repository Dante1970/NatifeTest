//
//  PostDetailsViewController.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    private let vm = PostDetailsViewModel()
    
    private let postID: Int
    private var post: PostDetails? {
        willSet(newPost) {
            DispatchQueue.main.async {
                guard let post = newPost else { return }
                
                self.titleLabel.text = post.title
                self.descriptionLabel.text = post.text
                self.likesStackView.likesLabel.text = "\(post.likesCount)"
                self.dateStackView.dateLabel.text = "\(post.formattedDate())"
                
                self.navigationItem.title = newPost?.title

                self.scrollView.contentSize = CGSize(
                    width: self.view.bounds.width,
                    height: self.calculateContentHeight())
            }
        }
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .white
        return activityIndicatorView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.numberOfLines = 0
        return label
    }()
    
    private let likesStackView = LikesStackView()
    private let dateStackView = DateStackView()
    
    private lazy var likesAndDateStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [likesStackView, spacer, dateStackView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, likesAndDateStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Init
    
    init(postID: Int) {
        self.postID = postID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureUI()
    }
    
    // MARK: - Private func
    
    private func getData() {
        vm.getPost(postID: "\(postID)") { [weak self] post in
            guard let self = self else { return }
            
            self.post = post
            
            DispatchQueue.main.async {
                self.activityIndicatorView.startAnimating()
            }
            
            self.vm.getImage(fromURL: post.postImage) { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
    
    // MARK: Make UI
    
    private func configureUI() {
        view.backgroundColor = ColorTheme.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        imageView.addSubview(activityIndicatorView)
        scrollView.addSubview(mainStackView)
        
        setupConstraints()
    }
    
    private func calculateContentHeight() -> CGFloat {
        let mainStackViewHeight = self.mainStackView.systemLayoutSizeFitting(
                        CGSize(width: self.view.bounds.width, height: 0),
                        withHorizontalFittingPriority: .required,
                        verticalFittingPriority: .fittingSizeLevel
                    ).height
        
        let imageHeight = self.view.bounds.width
        
        return mainStackViewHeight + imageHeight + 120
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalPadding: CGFloat = 20
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.width),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: horizontalPadding),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -horizontalPadding)
        ])
    }
}
