//
//  GHKeyChainStore.swift
//  DiscountCalculator
//
//  Created by 大帅 on 2022/5/26.
//

import Foundation
import KeychainAccess

public class GHKeyChainStore {
    public init(){ }
    public var keyChain: Keychain = {
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        return Keychain(service: bundleId + ".keyChainStore")
    }()

    public func setString(_ value: String, forKey: String) throws {
        try keyChain.set(value, key: forKey)
    }

    public func getString(_ key: String) throws -> String? {
        return try keyChain.getString(key)
    }

    public func setData(_ value:Data, forKey: String) throws {
        try keyChain.set(value, key: forKey)
    }

    public func getData(_ key: String) throws -> Data? {
        return try keyChain.getData(key)
    }

    public func removeAllValue() throws {
        try keyChain.removeAll()
    }
}

extension GHKeyChainStore {

    public func deviceUUIDKey() -> String {
        let bundleId = Bundle.main.bundleIdentifier ?? "com.SpringTech.NewSC"
        return bundleId + ".uuidKey"
    }

    public func deviceUUID() -> String {
        let key = deviceUUIDKey()
        if let uuid = try? getString(key) {
            return uuid
        }
        let uuid = UUID().uuidString
        
        do {
            try setString(uuid, forKey: key)
            return uuid
        } catch {}
        return ""
    }

}
