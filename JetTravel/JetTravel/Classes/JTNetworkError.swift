//
//  JTNetworkError.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 04/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import Foundation

enum JTNetworkError: Error {
    case invalidURL
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid host url. Please verify your requested url"
        case .invalidData:
            return "Unknown response."
        }
    }
}

enum JTNetworkResponseStatusCode: Int {
    case pageNotFount = 404
    case success = 200
}
