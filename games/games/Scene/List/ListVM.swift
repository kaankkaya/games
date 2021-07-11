//
//  ListVM.swift
//  games
//
//  Created by Kaan Kaya on 4.07.2021.
//

import UIKit

final class ListVM {
    weak var delegate: ListVMDelegate?
    
    private let service = GameService()
    
    // Game id by Image
    private var images: [Int:UIImage] = [:]
    
    func load(page: Int = 1, query: String? = nil) {
        service.request(query: query, page: page) { [weak self] items in
            guard let items = items else { return }
            
            items.forEach { self?.downloadAndCacheImage(for: $0.id, from: $0.imageURL) }
            
            self?.delegate?.handle(models: items.map { .init(model: $0) },
                                   page: page)
        }
    }
    
    func requestImage(for id: Int, link: String) {
        if let cachedImage = images[id] {
            delegate?.handle(image: cachedImage, for: id)
            
            return
        }
        
        downloadAndCacheImage(for: id, from: link)
    }
    
    // MARK: - Helpers
    private func downloadAndCacheImage(for id: Int, from link: String) {
        guard let url = URL(string: link),
              !images.keys.contains(id) else { return }
        url.downloadImage { [weak self] image in
            guard let image = image else { return }
            self?.delegate?.handle(image: image, for: id)
            self?.images[id] = image
            
        }
    }
}
