//
//  ImageUtils.swift
//  Games
//
//  Created by Joonik 5 on 6/20/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Haneke
import Foundation


class ImageUtils: NSObject {
    
    internal static let cache = Shared.imageCache
    
    
    
    class func getOriginalImage(_ path : String, callback : @escaping (UIImage)->Void) {
        let imageUrl = URL(string: path)
        let fetcher = NetworkFetcher<UIImage>(URL: imageUrl!)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            ImageUtils.cache.removeAllMemory()
            callback(image)
            } .onFailure {error in
                callback(UIImage(named: "default_cover")!)
        }
    }
    
    class func getPhoto(_ path : String, size : String,  callback : @escaping (UIImage)->Void) {
        let escapedImageName = path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let imageUrl = URL(string: escapedImageName!)
        let fetcher = NetworkFetcher<UIImage>(URL: imageUrl!)
        cache.fetch(fetcher: fetcher).onSuccess { image in
            ImageUtils.cache.removeAllMemory()
            callback(image)
        }
    }
    
}
