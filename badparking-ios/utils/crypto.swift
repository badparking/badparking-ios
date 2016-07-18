//
//  crypto.swift
//  badparking-ios
//
//  Created by Eugene Nagorny on 6/27/16.
//  Copyright © 2016 Eugene Nagorny. All rights reserved.
//

/*
 Based on SweetHMAC.swift
 https://github.com/jancassio/SweetHMAC
 */

import Foundation


import Foundation


public extension String {

    /**
     Proved a string for some HMAC algorithm and secret string.

     - parameter algorithm: Some HMAC algorithm. Supported types are:
     - SHA256
     - SHA384
     - SHA512

     - parameter secret: A secret message to authenticate the encrypted message.

     - returns: A encryped string based on HMAC algorithm and secret string.
     */
    func hmac(_ algorithm:HMACAlgorithm, secret:String) -> String {
        return SweetHMAC(message: self, secret: secret).HMAC(algorithm)
    }

    func sha256 () -> String {
        return SweetHMAC.sha256(self)
    }

    func sha384 () -> String {
        return SweetHMAC.sha384(self)
    }

    func sha512 () -> String {
        return SweetHMAC.sha512(self)
    }
}




/**
 HMACAlgoriths enumerates all HMAC algorithms types supported by iOS (not verified in Mac OS X environment yet)
 Supported iOS HMAC algorithms:

 - SHA256
 - SHA348
 - SHA512
 */
public enum HMACAlgorithm {
    case sha256, sha384, sha512

    /**
     Give the native value for HMACAlgorithm value

     - returns: The system `CCHmacAlgorithm` native value.
     */
    func toNative () -> CCHmacAlgorithm {
        switch self {
        case .sha256:
            return CCHmacAlgorithm( kCCHmacAlgSHA256 )

        case .sha384:
            return CCHmacAlgorithm( kCCHmacAlgSHA384 )

        case .sha512:
            return CCHmacAlgorithm( kCCHmacAlgSHA512 )
        }
    }

    func digestLength () -> Int {
        switch self {
        case .sha256:
            return Int( CC_SHA256_DIGEST_LENGTH )

        case .sha384:
            return Int( CC_SHA384_DIGEST_LENGTH )

        case .sha512:
            return Int( CC_SHA512_DIGEST_LENGTH )
        }
    }
}


public class SweetHMAC {

    struct UTF8EncodedString {

        var data:[CChar]
        var length:Int

        init(string:String) {
            data = string.cString(using: .utf8)!
            length = string.lengthOfBytes(using: .utf8)
        }
    }

    /// Message to be encrypted
    private var message:String = ""

    /// Secret message to authenticate the encrypted message.
    private var secret:String = ""

    /**
     Create a new SweetHMAC instance with given message and secret strings.
     - parameter message: The message to be encrypted.
     - parameter secret: The secret message to authenticate encrypted message.
     */
    public init(message:String, secret:String) {
        self.message = message
        self.secret = secret
    }

    /**
     Generate HMAC string with given algorithm.
     - parameter algorithm: Algorithm to encrypt message.
     - returns: A encrypted string.
     */
    public func HMAC(_ algorithm:HMACAlgorithm) -> String {
        let seed  = UTF8EncodedString(string: message)
        let key   = UTF8EncodedString(string: secret)

        let digestLength = algorithm.digestLength()
        let result = UnsafeMutablePointer<CUnsignedChar>.init(allocatingCapacity: digestLength)

        CCHmac(algorithm.toNative(), key.data, key.length, seed.data, seed.length, result)

        let hash = stringFromResult(result, length: digestLength)
        result.deinitialize()
        return hash as String
    }

    public class func sha256 (_ input: String) -> String {
        return digest(.sha256, input: input)
    }

    public class func sha384 (_ input: String) -> String {
        return digest(.sha384, input: input)
    }

    public class func sha512 (_ input: String) -> String {
        return digest(.sha512, input: input)
    }


    /**
     Generate abstraction for static methods
     - parameter algorithm: Algorithm to encrypt message.
     - parameter input: The string to be encrypted.
     - returns: A encrypted string.
     */
    private class func digest (_ algorithm: HMACAlgorithm, input: String) -> String {
        let seed  = UTF8EncodedString(string: input)
        let digestLength = algorithm.digestLength()
        let result = UnsafeMutablePointer<UInt8>.init(allocatingCapacity: digestLength)

        switch algorithm {
        case .sha256:
            CC_SHA256(seed.data, CC_LONG(seed.length), result)
            break

        case .sha384:
            CC_SHA384(seed.data, CC_LONG(seed.length), result)
            break

        case .sha512:
            CC_SHA512(seed.data, CC_LONG(seed.length), result)
            break
        }

        let hash = stringFromResult(result, length: digestLength)
        result.deinitialize()
        return hash as String
    }

    private class func stringFromResult(_ result:UnsafeMutablePointer<UInt8>, length: Int) -> String {
        let hash = NSMutableString()

        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return hash as String
    }

    private func stringFromResult(_ result:UnsafeMutablePointer<UInt8>, length: Int) -> String {
        return SweetHMAC.stringFromResult(result, length: length)
    }
}
