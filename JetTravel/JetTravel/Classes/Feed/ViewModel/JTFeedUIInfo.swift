//
//  JTFeedUIInfo.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 04/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import Foundation

class JTFeedUIInfo {
    
    private var feed: JTFeed!
    
    var userName: String? {
        guard let user = self.getUser() else { return nil }
        return user.name + " " + user.lastname
    }
    
    var userDesignation: String? {
        guard let user = self.getUser() else { return nil }
        return user.designation
    }
    
    var avatar: String? {
        guard let user = self.getUser() else { return nil }
        return user.avatar
    }
    
    var content: String? {
        return self.feed.content
    }
    
    var mediaTitle: String? {
        guard let media = self.getMedia() else { return nil }
        return media.title
    }
    
    var mediaUrl: String? {
        guard let media = self.getMedia() else { return nil }
        return media.url
    }
    
    var mediaImage: String? {
        guard let media = self.getMedia() else { return nil }
        return media.image
    }
    
    init(withFeed feed: JTFeed) {
        self.feed = feed
    }
    
    func getLikes() -> String {
        return self.feed.likes.roundedAbbreviationNumber
    }
    
    func getComments() -> String {
        return self.feed.comments.roundedAbbreviationNumber
    }
    
    func getTime() -> String {
        let date = Date().convertDate(fromString: self.feed.createdAt)
        return Date().timeAgoSinceDate(date: date)
    }
    
    private func getUser() -> JTUser? {
        return self.feed.user.first
    }
    
    private func getMedia() -> JTMedia? {
        return self.feed.media.first
    }
}
