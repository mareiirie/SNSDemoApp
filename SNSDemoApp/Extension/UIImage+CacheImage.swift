//
//  UIImage+CacheImage.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/11.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

extension UIImage {

    static let imageCache = NSCache<AnyObject, AnyObject>()
    static func cacheImage(from urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(cacheImage)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    completion(nil)
                    return
            }
            imageCache.setObject(image, forKey: urlString as AnyObject)
            DispatchQueue.mainSyncSafe {
                completion(image)
            }
        }.resume()
    }
}
extension DispatchQueue {
    class func mainSyncSafe(execute work: () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.sync(execute: work)
        }
    }
    class func mainSyncSafe<T>(execute work: () throws -> T) rethrows -> T {
        if Thread.isMainThread {
            return try work()
        } else {
            return try DispatchQueue.main.sync(execute: work)
        }
    }
}
