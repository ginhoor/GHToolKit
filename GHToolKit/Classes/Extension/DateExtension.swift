//
//  DateExtension.swift
//  GHToolKit
//
//  Created by 大帅 on 2022/7/21.
//

import Foundation

public extension Date {
    var gh: GHDateExtension {
        return GHDateExtension(self)
    }

    static var ghStatic: GHDateExtension.Type {
        return GHDateExtension.self
    }
}

public struct GHDateExtension {
    internal let date: Date
    internal init(_ date: Date) {
        self.date = date
    }

    public static var weekTimestampInterval: Double {
        return 60 * 60 * 24 * 7
    }

}
