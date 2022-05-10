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
    func getBaseURL(path: String, ts: String) -> String {
        let hashString = ts + KoloConstants.privateApiKey + KoloConstants.publicApiKey
        let md5HashString = hashString.MD5
        let urlString = KoloConstants.baseURL + path + "?ts=\(ts)&apikey=\(KoloConstants.publicApiKey)&hash=\(md5HashString)"
        return urlString
    }
 
}

extension String {
    var MD5: String {
            let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
            return computed.map { String(format: "%02hhx", $0) }.joined()
        }
}
