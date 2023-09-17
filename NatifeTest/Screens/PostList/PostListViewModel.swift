//
//  PostListViewModel.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import Foundation

class PostListViewModel {
    
    var state: ViewModelState = .initial
    
    weak var delegate: ViewModelDelegate?
    
    var posts: [Post] = []
    
    lazy var sortingOptions = [
        ("Time ⬆", { self.posts.sort { $0.timeshamp < $1.timeshamp } }),
        ("Time ⬇", { self.posts.sort { $0.timeshamp > $1.timeshamp } }),
        ("Likes ⬆", { self.posts.sort { $0.likesCount < $1.likesCount } }),
        ("Likes ⬇", { self.posts.sort { $0.likesCount > $1.likesCount } })
    ]
    
    func getPostList() {
        state = .loading
        self.delegate?.didUpdateState()
        
        guard let url = URL(string: Constants.postsURL) else { return }
        
        DataService.shared.get(url: url) { [weak self] (result: Result<MainResponse, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let posts):
                self.posts = posts.posts
                self.state = .loaded
            case .failure(let error):
                self.state = .error(message: "Error getting data. \(error)")
            }
            
            self.delegate?.didUpdateState()
        }
    }
}
