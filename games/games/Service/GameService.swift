//
//  GameService.swift
//  games
//
//  Created by Kaan Kaya on 11.07.2021.
//

import Foundation

final class GameService {
    enum Constants {
        static let count = 10
        static let page = 1
        static let key = "ff14887fe1234abab69328953995adda"
    }
    
    func detailRequest(id: Int, completion: @escaping (DetailDTO?) -> Void) {
        let urlString = "https://api.rawg.io/api/games/\(id)?&key=\(Constants.key)"
        
        guard let url = URL(string: urlString) else {
            print("URL could not parse!")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response could not parse!")
                completion(nil)
                return
            }
            
            guard (200..<400) ~= httpResponse.statusCode else {
                print("Response is not success!")
                completion(nil)
                
                return
            }
            
            guard
                let data = data,
                let model = try? JSONDecoder().decode(DetailDTO.self, from: data) else {
                print("Response could not decode!")
                completion(nil)
                
                return
            }
            
            completion(model)
        }.resume()
    }
    
    func request(query: String?, page: Int = Constants.page, completion: @escaping (([ListDTO]?) -> Void)) {
        let withQuery: Bool = query != nil
        let queryString = withQuery ? "&search=\(query!)" : ""
        guard let urlString = "https://api.rawg.io/api/games?page_size=\(Constants.count)&page=\(page)\(queryString)&key=\(Constants.key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }

        guard let url = URL(string: urlString) else {
            print("URL coul not parse!")
            
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Response could not parse!")
                completion(nil)
                
                return
            }
            
            guard (200..<400) ~= httpResponse.statusCode else {
                print("Response is not success!")
                completion(nil)
                
                return
            }
            
            guard
                let data = data,
                let model = try? JSONDecoder().decode(ListResponse.self, from: data) else {
                print("Response could not decode!")
                completion(nil)
                
                return
            }
            
            completion(model.results)
        }.resume()
    }
}
