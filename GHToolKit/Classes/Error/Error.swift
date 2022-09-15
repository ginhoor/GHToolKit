//
//  Error.swift
//  AXVToolKit
//
//  Created by 大帅 on 2022/8/3.
//

import Foundation

public struct GHError {
    enum Code: Int {
        case guardError = 1000
    }
}

public extension GHError {
    static let domain = "com.gh.error"
    static let guardElse = NSError(domain: domain, code: GHError.Code.guardError.rawValue, userInfo: nil)
}
