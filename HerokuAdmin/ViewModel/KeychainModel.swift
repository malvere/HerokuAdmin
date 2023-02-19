//
//  KeychainModel.swift
//  HerokuAdmin
//
//  Created by Kostya Kuznetsov on 19.12.2021.
//

import Foundation
import LocalAuthentication

class Keychain: ObservableObject {
    
    // Create KeyChain instance
    static func create(key: String, data: Data) -> OSStatus {
        remove(key: key)
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary
        
        return SecItemAdd(query, nil)
    }
    
    // Remove KeyChain instance
    static func remove(key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    // Load from DataBase
    static func load(key: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecUseAuthenticationUI: kSecUseAuthenticationUISkip
        ] as CFDictionary
        
        var keychainData: AnyObject? = nil
        let status = SecItemCopyMatching(query, &keychainData)
        
        if status == noErr {
            return (keychainData! as! Data)
        } else {
            return nil
        }
    }
    
    // AccessControl parameters, optional
    static var accessControl: SecAccessControl {
        return SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenUnlocked, .userPresence, nil)!
    }
    
}

