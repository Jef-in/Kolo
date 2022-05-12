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
    private let networkManger: NetworkManager
    var subscriptions = Set<AnyCancellable>()
    var characterDataSource = [CharacterResults]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    init(viewModel: CharacterViewModel,
         networkManager: NetworkManager) {
        self.viewModel = viewModel
        self.networkManger = networkManager
        super.init()
    }
    required init?(coder: NSCoder) {
        self.viewModel = CharacterViewModel(marvelService: MarvelService())
        self.networkManger = NetworkManager.shared
        self.networkManger.startMonitoring()
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCharacters()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        networkManger.stop()
    }
    
    func  loadCharacters() {
        if networkManger.isConnected {
            getCharacters()
        } else {
          showNetworkAlert()
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
    
    func searchCharacters(searchString: String) {
        if searchString.replacingOccurrences(of: " ", with: "") != "" {
            var filteredDataSource = [CharacterResults]()
            characterDataSource.map { character in
                guard let name = character.name else { return }
                if name.contains(searchString) {
                    filteredDataSource.append(character)
                }
            }
            characterDataSource = filteredDataSource
            DispatchQueue.main.async {
                self.charactersCollectionView.reloadData()
            }
        } else {
            loadCharacters()
        }
    }
}

extension CharactersTabViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCharacters(searchString: searchText)
    }
}

extension CharactersTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let character = characterDataSource[indexPath.row]
        let cacheItem = NSNumber(value: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.prepareForReuse()
        cell.configureCell(name: character.name ?? "", cacheItem: cacheItem, path: character.thumbnail?.path ?? "", imageExtension: character.thumbnail?.extension ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: 200)
    }
}

extension UIViewController {
    func showNetworkAlert() {
        let alertController = UIAlertController(title: "Network Connection", message: "Please check your network connection", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
