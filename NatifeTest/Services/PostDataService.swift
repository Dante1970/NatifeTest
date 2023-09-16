//
//  PostDataService.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import Foundation

class PostDataService {
    
    static let shared = PostDataService()
    private init() {}
    
    func getPost(postID: String, completion: @escaping (Result<Post, Error>) -> ()) {
        guard let url = URL(string: Constants.postURL + postID + ".json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let post = try JSONDecoder().decode(PostModel.self, from: data)
                completion(.success(post.post))
            } catch {
                print("Error decoding posts. \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
