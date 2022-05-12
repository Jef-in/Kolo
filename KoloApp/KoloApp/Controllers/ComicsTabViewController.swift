//
//  ComicsTabViewController.swift
//  KoloApp
//
//  Created by Jefin on 10/05/22.
//

import Combine
import UIKit

class ComicsTabViewController: UIViewController {
    private let viewModel: ComicViewModel
    private let networkManger: NetworkManager
    var subscriptions = Set<AnyCancellable>()
    var comicDataSource = [ComicResults]()
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    init(viewModel: ComicViewModel,
         networkManager: NetworkManager) {
        self.viewModel = viewModel
        self.networkManger = networkManager
        super.init()
    }
    required init?(coder: NSCoder) {
        self.viewModel = ComicViewModel(marvelService: MarvelService())
        self.networkManger = NetworkManager.shared
        self.networkManger.startMonitoring()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadComics()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        networkManger.stop()
    }
    
    func loadComics() {
        if networkManger.isConnected {
            getComics()
        } else {
            showNetworkAlert()
        }
    }
    
    func getComics() {
        viewModel.getComics().sink(receiveCompletion: {(completion) in
        }, receiveValue: { comics in
            guard let comicsData = comics else { return }
            self.comicDataSource = comicsData
            DispatchQueue.main.async {
                self.comicsCollectionView.reloadData()
            }
        }).store(in: &subscriptions)
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension ComicsTabViewController: filterComicsProtocol {
    func loadComicsWithFilter(type: String) {
        viewModel.filterType = type
        loadComics()
    }
}

extension ComicsTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let comic = comicDataSource[indexPath.row]
        let cacheItem = NSNumber(value: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.prepareForReuse()
        cell.configureCell(name: comic.title ?? "", cacheItem: cacheItem, path: comic.thumbnail?.path ?? "", imageExtension: comic.thumbnail?.extension ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 10, height: 200)
    }
}
