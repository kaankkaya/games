//
//  ListVM.swift
//  games
//
//  Created by Kaan Kaya on 4.07.2021.
//

import UIKit

final class ListVM {
    weak var delegate: ListVMDelegate?
    
//    private let service = GameService()
    
    var query: String? {
        didSet {
            guard query != nil else {
                killTimer()
                load()
                return
            }
            
            setTimer()
        }
    }
    
    private lazy var timer: Timer = {
        let timer = Timer.scheduledTimer(timeInterval: 0.8,
                                         target: self,
                                         selector: #selector(fireTimer),
                                         userInfo: nil,
                                         repeats: false)
        
        return timer
    }()
    
    // Game id by Image
    private var images: [Int:UIImage] = [:]
    
    deinit {
        killTimer()
    }
    
    func load(page: Int = 1) {
        app.service.request(query: query, page: page) { [weak self] items in
            guard let items = items else {
                print("ListVM: Items not found!")
                
                return
            }
            
//            items.forEach { self?.downloadAndCacheImage(for: $0.id, from: $0.imageURL) }
             
            self?.delegate?.handle(models: items.map { .init(model: $0) }, page: page)
        }
    }
    
    func requestImage(for id: Int, link: String) {
        if let cachedImage = images[id] {
            delegate?.handle(image: cachedImage, for: id)
            
            return
        }
        
        downloadAndCacheImage(for: id, from: link)
    }
    
    func killTimer() {
        timer.invalidate()
    }
    
    // MARK: - Helpers
    private func downloadAndCacheImage(for id: Int, from link: String) {
        guard let url = URL(string: link),
              !images.keys.contains(id) else { return }
        url.downloadImage(quality: 0.0) { [weak self] image in
            guard let image = image else { return }
            self?.delegate?.handle(image: image, for: id)
            self?.images[id] = image
        }
    }
    
    @objc private func fireTimer() {
        guard query != nil else { return }
        load()
    }
    
    private func setTimer() {
        killTimer()
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(fireTimer),
                                     userInfo: nil,
                                     repeats: false)
    }
}
