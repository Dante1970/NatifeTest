//
//  ViewController.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import UIKit

class PostsViewController: UIViewController {
    
    private let vm = PostsViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        vm.getPosts()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureUI()
    }
    
    // MARK: - Private func
    
    private func configureUI() {
        navigationItem.title = "Posts"
        
        let sortButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
            style: .plain,
            target: self,
            action: #selector(showSortAlert))
        navigationItem.rightBarButtonItem = sortButton
        
        tableView.backgroundColor = UIColor.theme.background
        
        view.addSubview(tableView)
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

// MARK: - UITableViewDelegate

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell = vm.posts[indexPath.row]
        
        let destination = PostDetailViewController(postID: selectedCell.postID)
        
        navigationController?.pushViewController(destination, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as! PostsTableViewCell
        
        cell.tableView = tableView
        cell.post = vm.posts[indexPath.row]
        
        return cell
    }
}
