//
//  ImageService.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import Foundation
import UIKit

class ImageService {
    
    static let shared = ImageService()
    private init() {}
    
    func getImage(fromURL url: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            if let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                print("Error getting image.")
            }
        }.resume()
    }
    
}
