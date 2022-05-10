//
//  MarvelService.swift
//  KoloApp
//
//  Created by Jefin on 10/05/22.
//

import Combine
import Foundation

public protocol MarvelServiceable {
    func getCharacters() -> AnyPublisher<CharacterModel, Error>
}

class MarvelService: MarvelServiceable {
    func getCharacters() -> AnyPublisher<CharacterModel, Error> {
        let path = "/v1/public/characters"
        guard let Url = URL(string: ServiceHelper.shared.getBaseURL(path: path, ts: "1")) else { preconditionFailure("failed to fectch the url")
            
        }
        let request = URLRequest(url: Url)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: CharacterModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
