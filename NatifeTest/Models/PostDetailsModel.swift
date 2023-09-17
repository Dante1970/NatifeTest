//
//  PostDetailsModel.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 16.09.2023.
//

import Foundation

struct PostDetailsModel: Codable {
    let post: PostDetails
}

struct PostDetails: Codable {
    let postID, timeshamp: Int
    let title, text: String
    let postImage: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}

extension PostDetails {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        let postDate = Date(timeIntervalSince1970: TimeInterval(self.timeshamp))
        return dateFormatter.string(from: postDate)
    }
}
