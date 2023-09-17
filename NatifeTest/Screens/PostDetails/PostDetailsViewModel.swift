//
//  PostDetailsViewModel.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import Foundation
import UIKit

class PostDetailsViewModel {
    
    func getPost(postID: String, completion: @escaping (PostDetails) -> ()) {
        guard let url = URL(string: Constants.postURL + postID + ".json") else { return }
        
        DataService.shared.get(url: url) { (result: Result<PostDetailsModel, Error>) in
            switch result {
            case .success(let postModel):
                completion(postModel.post)
            case .failure(let error):
                print("Error getting data. \(error)")
            }
        }
    }
    
    func getImage(fromURL url: String?, completion: @escaping (UIImage) -> ()) {
        guard let url = url else {
            print("Error! url is nil.")
            return
        }
        
        ImageService.shared.getImage(fromURL: url) { results in
            switch results {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
