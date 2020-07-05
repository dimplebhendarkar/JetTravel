//
//  JTFeedNetworkManager.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 04/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import Foundation

typealias successHandler = ([JTFeedUIInfo]) -> Void
typealias failureHandler = (Error?) -> Void

class JTFeedNetworkManager {
    
    static let manager = JTFeedNetworkManager()
    private init() { }
    
    func getFeed(withPage pageNumber: Int, withSuccess success: @escaping successHandler, withFailuer failure: @escaping failureHandler) {
        let urlString = URL_FEED.replacingOccurrences(of: "{pageNumber}", with: "\(pageNumber)")
        print("urlString", urlString)
        guard let url = URL(string: urlString) else {
            failure(JTNetworkError.invalidURL)
            return
        }
        let request = URLRequest(url: url)
        
        JTNetworkManager.get(withRequest: request) { (data, urlResponse, error) in
    
            if let responseErr = error {
                failure(responseErr)
                return
            }
            
            guard let responseData = data,
                let httpResponse = urlResponse as? HTTPURLResponse else {
                    failure(JTNetworkError.invalidData)
                return
            }
            
            let stautsCode = JTNetworkResponseStatusCode(rawValue: httpResponse.statusCode)
            
            if stautsCode == .success {
                
                do {
                    let utf8String = String(data: responseData, encoding: String.Encoding.utf8)
                    guard let utf8Data = utf8String?.data(using: .utf8) else { return }
                    let feed = try JSONDecoder().decode([JTFeed].self, from: utf8Data)
                    let feedUIInfos = feed.compactMap{ JTFeedUIInfo.init(withFeed: $0) }
                    success(feedUIInfos)
                    
                } catch let exception {
                    failure(exception)
                }
                
            } else {
                failure(error)
            }
            
        }
    }
    
}
