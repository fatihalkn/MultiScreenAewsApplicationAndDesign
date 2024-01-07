//
//  Model.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import Foundation

class Model {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data?
    let publishedAt : String
    
    init(title: String, subtitle: String, imageURL: URL?, imageData: Data?, publishedAt: String) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.imageData = imageData
        self.publishedAt = publishedAt
        
    }
}

struct MenuModel {
    let type: MenuType
    let title: String
}

enum MenuType {
    case tech
    case science
    case education
    case business
}
