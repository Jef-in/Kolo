//
//  CharacterModel.swift
//  KoloApp
//
//  Created by Jefin on 10/05/22.
//

public class CharacterModel : Codable {
    let code: Int?
    let status: String?
    let data: Data?
}
public struct Data: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharacterResults]?
}
public class CharacterResults: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let resourceURI: String?
    let thumbnail: Thumbnail?
}
public class Thumbnail: Codable {
    let path: String?
    let `extension`: String?
}
