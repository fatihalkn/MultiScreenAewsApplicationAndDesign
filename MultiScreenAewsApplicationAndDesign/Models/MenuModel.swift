//
//  MenuModels.swift
//  MultiScreenAewsApplicationAndDesign
//
//  Created by Fatih on 6.01.2024.
//

import Foundation


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
