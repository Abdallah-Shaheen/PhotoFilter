//
//  Photo.swift
//  PhotoFilter
//
//  Created by Abdallah Shaheen on 6/3/18.
//  Copyright © 2018 Me. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case albumId
        case id
        case title
        case url
        case thumbnailUrl
    }
}
