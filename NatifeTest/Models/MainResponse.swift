//
//  PostListModel.swift
//  NatifeTest
//
//  Created by Сергей Белоусов on 15.09.2023.
//

import Foundation

struct MainResponse: Codable {
    let posts: [Post]
}

struct Post: Codable, Comparable {
    
    let postID, timeshamp: Int
    let title, previewText: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
    
    static func < (lhs: Post, rhs: Post) -> Bool {
        return lhs.timeshamp < rhs.timeshamp
    }
}

extension Post {
    func daysAgo() -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let postDate = Date(timeIntervalSince1970: TimeInterval(self.timeshamp))
        
        let components = calendar.dateComponents([.day], from: postDate, to: currentDate)
        
        if let days = components.day, days > 0 {
            return "\(days) day\(days > 1 ? "s" : "") ago"
        } else {
            return "today"
        }
    }
}
