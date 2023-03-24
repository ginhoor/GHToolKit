//
//  URL+Extension.swift
//  GHToolKit
//
//  Created by 大帅 on 2022/10/27.
//

import Foundation
import Foundation

public extension URL {
    static var Gh: GHToolKitURLExtension.Type {
        return GHToolKitURLExtension.self
    }

    var gh: GHToolKitURLExtension {
        return GHToolKitURLExtension(self)
    }
}

public struct GHToolKitURLExtension {
    internal let url: URL
    internal init(_ url: URL) {
        self.url = url
    }
}

public extension GHToolKitURLExtension {

    var lastPathName: String {

        if self.url.pathExtension.isEmpty { return self.url.lastPathComponent }

        let results = self.url.lastPathComponent.split(separator: ".")
        return String(results.first ?? "")
    }

}
