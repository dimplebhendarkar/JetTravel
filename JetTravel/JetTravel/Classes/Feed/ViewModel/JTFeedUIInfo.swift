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
    
    init(withFeed feed: JTFeed) {
        self.feed = feed
    }
    
    func getLikes() -> String {
        return "\(self.feed.likes)"
    }
}
