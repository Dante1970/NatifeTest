//
//  PostListViewModel.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import Foundation

class PostListViewModel {
    
    var posts: [Post] = []
    var updateUI: (() -> ())?
    lazy var sortingOptions = [
        ("Time ⬆", { self.posts.sort { $0.timeshamp < $1.timeshamp } }),
        ("Time ⬇", { self.posts.sort { $0.timeshamp > $1.timeshamp } }),
        ("Likes ⬆", { self.posts.sort { $0.likesCount < $1.likesCount } }),
        ("Likes ⬇", { self.posts.sort { $0.likesCount > $1.likesCount } })
    ]
    
    func getPosts() {
        guard let url = URL(string: Constants.postsURL) else { return }
        
        DataService.shared.get(url: url) { (result: Result<MainResponse, Error>) in
            switch result {
            case .success(let posts):
                self.posts = posts.posts
                self.updateUI?()
            case .failure(let error):
                print("Error getting data. \(error)")
            }
        }
    }
}
