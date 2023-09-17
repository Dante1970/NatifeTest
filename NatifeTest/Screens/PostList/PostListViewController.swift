//
//  PostListViewController.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import UIKit

class PostListViewController: UIViewController, ViewModelDelegate {
    
    private let vm = PostListViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(PostListTableViewCell.self, forCellReuseIdentifier: PostListTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = ColorTheme.background
        return tableView
    }()
    
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Public func
    
    func didUpdateState() {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI()
        }
    }
    
    // MARK: - Private func
    
    private func updateUI() {
        switch vm.state {
        case .initial:
            
            activityIndicator.isHidden = true
            
            tableView.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            
            vm.delegate = self
            vm.getPostList()

            configureUI()
            
        case .loading:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            tableView.isHidden = true
        case .loaded:
            tableView.isHidden = false
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            tableView.reloadData()
        case .error(let message):
            tableView.isHidden = true
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            print(message)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = ColorTheme.background
        configureNavigationBar()
        addSubview()
        setupConstraints()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Posts"
        
        let sortButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
            style: .plain,
            target: self,
            action: #selector(showSortAlert))
        navigationItem.rightBarButtonItem = sortButton
    }
    
    private func addSubview() {
        view.addSubview(activityIndicator)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func showSortAlert() {
        let alert = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .alert)
        
        _ = vm.sortingOptions.map { (title, action) in
            let button = UIAlertAction(title: title, style: .default) { [weak self] _ in
                guard let self = self else { return }
                
                action()
                
                self.tableView.reloadData()
            }
            alert.addAction(button)
        }
        
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - extension UITableViewDelegate

extension PostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = vm.posts[indexPath.row]
        let destination = PostDetailsViewController(postID: selectedCell.postID)
        navigationController?.pushViewController(destination, animated: true)
    }
}

// MARK: -  extension UITableViewDataSource

extension PostListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.identifier, for: indexPath) as! PostListTableViewCell
        
        cell.tableView = tableView
        cell.post = vm.posts[indexPath.row]
        
        return cell
    }
}
