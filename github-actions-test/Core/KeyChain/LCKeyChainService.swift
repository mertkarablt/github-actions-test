//
//  LCKeychainService.swift
//  LCore
//
//  Created by Mert Karabulut on 01.05.2021.
//

import Foundation
import Security

public class LCKeyChainService: NSObject {
    // Constant Identifiers
    private static let userAccount = "AuthenticatedUser"
    private static let accessGroup = "SecurityService"
    /**
     * Exposed methods to perform save and load queries.
     */
    public class func reset() {
        resetKeychain()
    }
    // saving
    public class func saveData(key: String, value: Data) {
        saveData(service: key, data: value)
    }
    public class func saveObject<T: Any>(
        key: String,
        value: T,
        usingEncoder encoder: JSONEncoder = JSONEncoder()
    ) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
            saveData(service: key, data: data)
        } catch let error {
            print("Failed to encode with error \(error)")
        }
    }
    public class func save<T: Codable>(
        key: String,
        value: T,
        usingEncoder encoder: JSONEncoder = JSONEncoder()
    ) {
        do {
            let data = try encoder.encode(value)
            saveData(service: key, data: data)
        } catch let error {
            print("Failed to encode with error \(error)")
        }
    }
    // retreiving
    public class func data(forKey key: String) -> Data? {
        return loadData(key: key)
    }
    public class func readObject<T: NSCoding>(
        _ type: T.Type,
        with key: String,
        usingDecoder decoder: JSONDecoder = JSONDecoder()
    ) -> T? {
        guard let data = LCKeyChainService.loadData(key: key) else { return nil }
        do {
            let restoredItem = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
            return restoredItem
        } catch let error {
            print("Failed to decode with error \(error)")
            return nil
        }
    }
    public class func read<T: Codable>(
        _ type: T.Type,
        with key: String,
        usingDecoder decoder: JSONDecoder = JSONDecoder()
    ) -> T? {
        guard let data = LCKeyChainService.loadData(key: key) else { return nil }
        do {
            let restoredItem = try decoder.decode(type.self, from: data)
            return restoredItem
        } catch let error {
            print("Failed to decode with error \(error)")
            return nil
        }
    }

    /**
     * Internal methods for querying the keychain.
     */
    private class func saveData(service: String, data: Data) {
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary =
            NSMutableDictionary(
                objects: [
                    kSecClassGenericPassword,
                    service,
                    userAccount,
                    data
                ],
                forKeys: [
                    kSecClass as NSString,
                    kSecAttrService as NSString,
                    kSecAttrAccount as NSString,
                    kSecValueData as NSString
                ]
            )

        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)

        // Add the new keychain item
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }

    private class func loadData(key: String) -> Data? {
        return load(service: key)
    }

    private class func load<T>(service: String) -> T? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary =
            NSMutableDictionary(
                objects: [
                    kSecClassGenericPassword,
                    service,
                    userAccount,
                    kCFBooleanTrue,
                    kSecMatchLimitOne
                ],
                forKeys: [
                    kSecClass as NSString,
                    kSecAttrService as NSString,
                    kSecAttrAccount as NSString,
                    kSecReturnData as NSString,
                    kSecMatchLimit as NSString
                ]
            )

        var dataTypeRef: AnyObject?

        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: T?

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = retrievedData as? T
            }
        } else {
            log("Nothing was retrieved from the keychain for key \(service). Status code \(status)")
        }
        return contentsOfKeychain
    }

    private class func resetKeychain() {
        let query = [
            (kSecClass as String): kSecClassGenericPassword
        ]
        if SecItemDelete(query as CFDictionary) != noErr {
            log("Couldn't clear keychain.")
        }
    }
}
