//
//  CharacterViewModel.swift
//  KoloApp
//
//  Created by Jefin on 11/05/22.
//

import Combine
import Foundation
import UIKit

 protocol CharacterViewable {
    func getCharacters() -> AnyPublisher<[CharacterResults]?, Error>
}

class CharacterViewModel: CharacterViewable {
   
    private let marvelService: MarvelService
    var subscriptions = Set<AnyCancellable>()
    
    init(marvelService: MarvelService) {
        self.marvelService = marvelService
    }
    
    func getCharacters() -> AnyPublisher<[CharacterResults]?, Error>{
        marvelService.getCharacters()
            .map(\.data?.results)
            .eraseToAnyPublisher()
    }

}
