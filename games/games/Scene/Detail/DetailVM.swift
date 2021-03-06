//
//  DetailVM.swift
//  games
//
//  Created by Kaan Kaya on 13.07.2021.
//

import Foundation

final class DetailVM {
    weak var delegate: DetailVMDelegate?
    
    var item: DetailDTO?
    private var imageData: Data?
    
    private let id: Int
    
    var isFavorited: Bool {
        let favoritesData = app.userDefaults.array(forKey: app.userDefaultsKey) as! [Data]
        let favorites = favoritesData.compactMap { try? JSONDecoder().decode(FavoriteDTO.self, from: $0) }
        
        return favorites.contains(where: { $0.id == id })
    }
    
    init(id: Int) {
        self.id = id
    }
    
    func load() {
        app.service.detailRequest(id: id) { model in
            guard let model = model else {
                print("DetailVM: Models not found!")
                
                return
            }
            
            // Description
            
            self.item = model
            self.delegate?.reloadData()
            // Image
            let imageURLString = model.additionalImageLink ?? model.imageLink
            
            if let imageURL = URL(string: imageURLString) {
                imageURL.downloadImage(quality: 0.5) { [weak self] image in
                    guard let image = image else { return }
                    self?.imageData = image.jpegData(compressionQuality: 1)
                    self?.delegate?.handleImage(image)
                }
            }
        }
    }
    
    func toggleFavorite() {
        var favoritesData = app.userDefaults.array(forKey: app.userDefaultsKey) as! [Data]
        var favorites = favoritesData.compactMap { try? JSONDecoder().decode(FavoriteDTO.self, from: $0) }
        
        if favorites.contains(where: { $0.id == id }) {
            favorites.removeAll(where: { $0.id == id })
        } else {
            guard let item = item,
                  let imageData = imageData else {
                print("Item could not be favorited!")
                
                return
            }
            
            favorites.append(.init(gameDTO: item, imageData: imageData))
        }
        
        favoritesData = favorites.compactMap { try? JSONEncoder().encode($0) }
        
        app.userDefaults.setValue(favoritesData, forKey: app.userDefaultsKey)
    }
}
