//
//  DataService.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 17.09.2023.
//

import Foundation

import Foundation

class DataService {
    
    static let shared = DataService()
    private init() {}
    
    func get<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError.badURL as! Error))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Error decoding. \(error.localizedDescription)")
            }
        }.resume()
    }
}
