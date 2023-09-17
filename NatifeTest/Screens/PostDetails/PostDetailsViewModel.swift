//
//  PostDetailsViewModel.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import Foundation
import UIKit

class PostDetailsViewModel {
    var state: ViewModelState = .initial
    
    weak var delegate: ViewModelDelegate?
    
    func getPostDetails(postID: String, completion: @escaping (PostDetails) -> ()) {
        state = .loading
        delegate?.didUpdateState()
        
        guard let url = URL(string: Constants.postURL + postID + ".json") else { return }
        
        DataService.shared.get(url: url) { [weak self] (result: Result<PostDetailsModel, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let postModel):
                completion(postModel.post)
                self.state = .loaded
            case .failure(let error):
                self.state = .error(message: error.localizedDescription)
            }
            
            self.delegate?.didUpdateState()
        }
    }
}
