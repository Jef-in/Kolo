//
//  CharacterModel.swift
//  KoloApp
//
//  Created by Jefin on 10/05/22.
//

public struct CharacterModel : Codable {
    let code : String?
    let status : String?
    let data : Data?
    
    public struct Data : Codable {
        let offset : String?
        let limit : String?
        let total : String?
        let count : String?
        let results : [Results]?
        
        public struct Results : Codable {
            let id : String?
            let name : String?
            let description : String?
            let modified : String?
            let resourceURI : String?
            let thumbnail : Thumbnail?
            
            public struct Thumbnail : Codable {
                let path : String?
                let Extension : String?
                
                enum Thumbnail: String, CodingKey {
                    case path = "path"
                    case Extension = "extension"
                }
            }
        }
    }
}
