//
//  ComicModel.swift
//  KoloApp
//
//  Created by Jefin on 11/05/22.
//

import Foundation

public class ComicModel: Codable {
    let code: Int?
    let status: String?
    let data: ComicData?
}

public class ComicData: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [ComicResults]?
}

public class ComicResults: Codable {
    let id: Int?
    let title: String?
    let modified: String?
    let pageCount: Int?
    let thumbnail: Thumbnail?
}
