//
//  JTImageCache.swift
//  JetTravel
//
//  Created by Nishant Kumbhare on 05/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import Foundation
import UIKit

final class JTImageCache {
    static let cache = JTImageCache()
    private init() { }
    
    private typealias completionHandler = (Bool) -> Void
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage?, forKey key: String) {
        guard let newImage = image else { return }
        self.compareImage(newImage, forKey: key) { isAvailable in
            if !isAvailable {
                self.imageCache.setObject(newImage, forKey: key as NSString)
            }
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return self.getImage(key)
    }
    
    func removeImage(forKey key: String) {
        guard  self.getImage(key) != nil else { return }
        self.imageCache.removeObject(forKey: key as NSString)
    }
    
    func removeAllImage() {
        self.imageCache.removeAllObjects()
    }
}

extension JTImageCache {
    
    private func getImage(_ key: String) -> UIImage? {
        guard let image = self.imageCache.object(forKey: key as NSString) else { return nil }
        return image
    }
    
    private func compareImage(_ newImage: UIImage, forKey key: String, withCompletionHandler completionHandler: completionHandler) {
        
        guard let newImageData: NSData = newImage.pngData() as NSData? else {
            completionHandler(false)
            return  }
        
        guard let oldImage = self.getImage(forKey: key),
            let oldImageData: NSData = oldImage.pngData() as NSData? else {
            completionHandler(false)
            return }
        
        if newImageData.isEqual(to: oldImageData as Data) {
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
    
}
