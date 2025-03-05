//
//  ListItem.swift
//  LazyLoadingListApp
//
//  Created by Ajay Kunte on 05/03/25.
//

import Foundation

struct ListItem: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let thumbnailUrl: String
    
    var imageUrl: URL? {
        return URL(string: thumbnailUrl)
    }
}
