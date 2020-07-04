//
//  JTFeed.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 04/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import Foundation

struct JTFeed: Codable {
    var id: String
    var createdAt: String
    var content: String
    var comments: Int
    var likes: Int
    var media: [JTMedia]
    var user: [JTUser]
}

struct JTMedia: Codable {
    var id: String
    var blogId: String
    var createdAt: String
    var image: String
    var title: String
    var url: String
}

struct JTUser: Codable {
    var id: String
    var blogId: String
    var createdAt: String
    var name: String
    var avatar: String
    var lastname: String
    var city: String
    var designation: String
    var about: String
}
