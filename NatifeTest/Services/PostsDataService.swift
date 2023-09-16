//
//  PostsDataService.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import Foundation

class PostsDataService {
    
    static let shared = PostsDataService()
    private init() {}
    
    func getPosts(completion: @escaping (Result<[PostList], Error>) -> ()) {
        guard let url = URL(string: Constants.postsURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let posts = try JSONDecoder().decode(Posts.self, from: data)
                completion(.success(posts.posts))
            } catch {
                print("Error decoding posts. \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
