//
//  MarvelService.swift
//  KoloApp
//
//  Created by Jefin on 10/05/22.
//

import Combine
import Foundation
import UIKit

public protocol MarvelServiceable {
    func getCharacters() -> AnyPublisher<CharacterModel, Error>
    func getComics(filterType: String) -> AnyPublisher<ComicModel, Error>
    func getImage(path: String, imageExtension: String) -> AnyPublisher<UIImage, URLError>
}

class MarvelService: MarvelServiceable {

    func getCharacters() -> AnyPublisher<CharacterModel, Error> {
        let path = "/v1/public/characters"
        guard let Url = URL(string: ServiceHelper.shared.getURL(path: path, ts: "1")) else { preconditionFailure("failed to fetch the url")
            
        }
        let request = URLRequest(url: Url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: CharacterModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getComics(filterType: String) -> AnyPublisher<ComicModel, Error> {
        let path = "/v1/public/comics"
        
        var urlString = ServiceHelper.shared.getURL(path: path, ts: "1")
        if filterType != "" {
            urlString += "&dateDescriptor=\(filterType)"
        }
        guard let Url = URL(string: urlString) else { preconditionFailure("failed to fetch the url") }
        
        let request = URLRequest(url: Url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: ComicModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getImage(path: String, imageExtension: String) -> AnyPublisher<UIImage, URLError> {
        guard let Url = URL(string: ServiceHelper.shared.configureImageURL(path: path, imageExtension: imageExtension)) else { preconditionFailure("failed to fetch the url") }
            
        let request = URLRequest(url: Url)
            
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({ [unowned self] result in
                guard let image = UIImage(data: result.data) else { return UIImage() }
                return image
            })
            .eraseToAnyPublisher()
    }
}
