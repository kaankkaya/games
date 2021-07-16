//
//  URL.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import UIKit

extension URL {
    func downloadImage(quality: CGFloat, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: self) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let data = data,
                error == nil,
                let image = UIImage(data: data),
                let compressedData = image.jpegData(compressionQuality: quality),
                let compressedImage = UIImage(data: compressedData)
            else {
                completion(nil)
                return
            }
            completion(compressedImage)
        }.resume()
    }
}
