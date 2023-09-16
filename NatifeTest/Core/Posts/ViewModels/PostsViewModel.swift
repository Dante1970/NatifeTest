//
//  PostsViewModel.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import Foundation

class PostsViewModel {
    
    var posts: [PostList] = []
    var updateUI: (() -> ())?
    lazy var sortingOptions = [
        ("Time ⬆", { self.posts.sort { $0.timeshamp < $1.timeshamp } }),
        ("Time ⬇", { self.posts.sort { $0.timeshamp > $1.timeshamp } }),
        ("Likes ⬆", { self.posts.sort { $0.likesCount < $1.likesCount } }),
        ("Likes ⬇", { self.posts.sort { $0.likesCount > $1.likesCount } })
    ]
    
    func getPosts() {
        PostsDataService.shared.getPosts { [weak self] results in
            switch results {
            case .success(let posts):
                self?.posts = posts
                self?.updateUI?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
