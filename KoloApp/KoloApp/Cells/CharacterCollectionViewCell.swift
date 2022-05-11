//
//  CharacterCollectionViewCell.swift
//  KoloApp
//
//  Created by Jefin on 10/05/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }
    
    func configureCell(name: String, cacheItem: NSNumber, path: String, imageExtension: String) {
        DispatchQueue.main.async {
            self.characterNameLabel.text = name
            self.characterImageView.getCachedImage(cacheItem: cacheItem, path: path,  imageExtension: imageExtension)
        }
    }
}
