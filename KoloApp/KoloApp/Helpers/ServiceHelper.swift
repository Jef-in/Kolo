//
//  ServiceHelper.swift
//  KoloApp
//
//  Created by Jefin on 10/05/22.
//

import CryptoKit
import Foundation

class ServiceHelper {
    static let shared = ServiceHelper()
    func getURL(path: String, ts: String) -> String {
        let hashString = ts + KoloConstants.privateApiKey + KoloConstants.publicApiKey
        let md5HashString = hashString.MD5
        let urlString = KoloConstants.baseURL + path + "?ts=\(ts)&apikey=\(KoloConstants.publicApiKey)&hash=\(md5HashString)"
        return urlString
    }
 
    func configureImageURL(path: String, imageExtension: String) -> String {
        let imageUrlString = path + "/portrait_xlarge." + imageExtension
        return imageUrlString
    }
}

extension String {
    var MD5: String {
            let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
            return computed.map { String(format: "%02hhx", $0) }.joined()
        }
}
