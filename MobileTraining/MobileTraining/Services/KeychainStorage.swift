//
//  KeychainStorage.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 30.06.23.
//

import Foundation
import KeychainAccess

class KeychainStorage {
    @Published var keychain = Keychain(service: "com.accedia.svdo.MobileTraining.keychain")
    @Published var accessTokenKey = "access_token"
    
    func storeAccessToken(_ accessToken: String?) {
        if let accessToken = accessToken {
            keychain[accessTokenKey] = accessToken
        } else {
            keychain[accessTokenKey] = nil
        }
    }
}
