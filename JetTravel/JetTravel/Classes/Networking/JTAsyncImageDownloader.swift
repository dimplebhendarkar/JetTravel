//
//  JTAsyncImageDownloader.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 05/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import Foundation
import UIKit

typealias imageHandler = (UIImage?) -> Void
class JTAsyncImageDownloader {
    
    static let instance = JTAsyncImageDownloader()
    private init() {}
    
    private let imageCache = JTImageCache.cache
    
    let dispatchQueue = DispatchQueue(label: "com.dimpalbhendarkar.asyncimagedownloder", qos: .background, attributes: .concurrent)
    
    func downloadImage(withURLString urlString: String, _ completionHandler: @escaping imageHandler) {
        
        dispatchQueue.async {
            
            if let image = self.imageCache.getImage(forKey: urlString) {
                completionHandler(image)
            } else {
                
                guard let url = URL(string: urlString) else {
                    completionHandler(nil)
                    return }
                let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let imageData = data, let image = UIImage(data: imageData) else {
                        completionHandler(nil)
                        return
                    }
                    completionHandler(image)
                    guard let urlString = response?.url?.absoluteString else { return }
                    self.imageCache.setImage(image, forKey: urlString)
                }
                dataTask.resume()
            }
        }
    }
}
