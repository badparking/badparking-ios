//
//  crypto.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 6/27/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

import Foundation


func sha256(_ string : String) -> String {
    let data = string.data(using: String.Encoding.utf8)!

    var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
    data.withUnsafeBytes {
        _ = CC_SHA256($0, CC_LONG(data.count), &hash)
    }

    return (hash.map({ String(format: "%02x", $0) })).joined(separator: "")
}
