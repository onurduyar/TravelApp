//
//  UIImageView+Extensions.swift
//  TravelApp
//
//  Created by Onur Duyar on 30.06.2023.
//

import UIKit

let cache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func downloadImage(from url: URL?){
        guard let url else {
            return
        }
        if let image = cache.object(forKey: url.absoluteString as NSString) as? UIImage{
            self.image = image
            return
        }
        
        let session = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                fatalError(error.localizedDescription)
            }
            guard let data,let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
            cache.setObject(image, forKey: url.absoluteString as NSString)
        }
        task.resume()
    }
}
