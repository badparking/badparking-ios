//
//  BackendAuth.swift
//  BadParking
//
//  Created by Eugene Nagorny on 10/30/16.
//  Copyright © 2016 BadParking. All rights reserved.
//

import UIKit
import JWT

class AuthManager: NSObject {
    static let shared = AuthManager()
    let defaults = UserDefaults.standard

    private override init() {
        return;
    }

    var token: String? {
        get {
            return defaults.value(forKey: "token") as? String
        }
        set {
            if let token = newValue {
                defaults.set(token, forKey: "token")
            }
        }
    }

    func isTokenSoftExpired() -> Bool {
        guard let token = self.token else {
            return true
        }
        do {
            let payload = try JWT.decode(token, algorithm: .hs256(Constants.API.ClientSecret.data(using: .utf8)!))
            print(payload)
            return false
        } catch {
            print("Failed to decode JWT: \(error)")
            return true
        }
    }

    func isTokenHardExpired(token: String) -> Bool {
        guard (self.token != nil) else {
            return true
        }
        // validation should be performed on server side
        return false
    }

    func generateSecret() -> Dictionary<String, String> {
        let timestamp = Int(Date().timeIntervalSince1970)
        let secret = "\(Constants.API.ClientSecret)\(timestamp)".sha256()
        return ["client_id": Constants.API.ClientID, "client_secret": secret, "timestamp": "\(timestamp)"]
    }
}
