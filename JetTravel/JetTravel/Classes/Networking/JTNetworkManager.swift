//
//  JTNetworkManager.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 04/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import Foundation

typealias completionHandler = (Data?, URLResponse?, Error?) -> Void

class JTNetworkManager {
    
    class func get(withRequest request: URLRequest, withCompletionHandler completionHandler: @escaping completionHandler) {
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, urlResponse, error) in
            completionHandler(data, urlResponse, error)
        }
        dataTask.resume()
    }
    
}
