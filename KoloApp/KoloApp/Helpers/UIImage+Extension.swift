//
//  UIImage+Extension.swift
//  KoloApp
//
//  Created by Jefin on 11/05/22.
//

import UIKit

extension UIImageView {
    func getCachedImage(cacheItem: NSNumber, path: String, imageExtension: String) {
        let cache = NSCache<NSNumber, UIImage>()
        if let cachedImage = cache.object(forKey: cacheItem) {
            print("Using a cached image for item: \(cacheItem)")
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            
        } else {
            guard let Url = URL(string: ServiceHelper.shared.configureImageURL(path: path, imageExtension: imageExtension)) else { preconditionFailure("failed to fetch the url") }
                
            let request = URLRequest(url: Url)
            URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
                if let data = data {
                    guard let image = UIImage(data: data) else { return }
                    cache.setObject(image, forKey: cacheItem)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}
