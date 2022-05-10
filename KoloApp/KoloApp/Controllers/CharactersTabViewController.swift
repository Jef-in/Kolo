//
//  CharactersTabViewController.swift
//  KoloApp
//
//  Created by Jefin on 10/05/22.
//

import Combine
import UIKit

class CharactersTabViewController: UIViewController {
   
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    private let viewModel: CharacterViewModel
    var subscriptions = Set<AnyCancellable>()
    var characterDataSource = [CharacterResults]()
    
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    required init?(coder: NSCoder) {
        self.viewModel = CharacterViewModel(marvelService: MarvelService())
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCharacters()
        DispatchQueue.main.async {
            self.charactersCollectionView.reloadData()
        }
    }
    
    func getCharacters() {
        viewModel.getCharacters().sink(receiveCompletion: {(completion) in
            
        }, receiveValue: { characters in
            guard let charactersData = characters else { return }
            self.characterDataSource = charactersData
            DispatchQueue.main.async {
                self.charactersCollectionView.reloadData()
            }
        }).store(in: &subscriptions)
    }
}

extension CharactersTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let character = characterDataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.characterNameLabel.text = character.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: 200)
    }
}
