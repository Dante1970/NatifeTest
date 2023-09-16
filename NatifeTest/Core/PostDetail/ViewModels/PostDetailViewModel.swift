//
//  PostDetailViewModel.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import Foundation
import UIKit

class PostDetailViewModel {
    
    func getPost(postID: String, completion: @escaping (Post) -> ()) {
        PostDataService.shared.getPost(postID: postID) { results in
            switch results {
            case .success(let post):
                completion(post)
            case.failure(let error):
                print(error)
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
