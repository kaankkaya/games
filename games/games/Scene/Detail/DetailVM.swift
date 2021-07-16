//
//  DetailVM.swift
//  games
//
//  Created by Kaan Kaya on 13.07.2021.
//

import Foundation

final class DetailVM {
    weak var delegate: DetailVMDelegate?
    
    var item: GameDTO?
    
    private let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    func load() {
        app.service.detailRequest(id: id) { model in
            guard let model = model else {
                print("DetailVM: Models not found1")
                
                return
            }
            
            // Description
            
            self.item = model
            self.delegate?.reloadData()
            // Image
            if let additionalImageURL = URL(string: model.additionalImageLink) {
                additionalImageURL.downloadImage(quality: 0.5) { [weak self] additionalImage in
                    if let additionalImage = additionalImage {
                        self?.delegate?.handleImage(additionalImage)
                    } else {
                        // Set defautlt
                        if let imageURL = URL(string: model.imageLink) {
                            imageURL.downloadImage(quality: 0.5) { [weak self] image in
                                guard let image = image else {
                                    print("Image could not be downloaded for detail!")
                                    
                                    return
                                }
                                self?.delegate?.handleImage(image)
                            }
                        }
                    }
                }
            }
        }
    }
}
