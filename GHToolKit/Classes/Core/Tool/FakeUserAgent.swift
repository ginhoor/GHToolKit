//
//  FakeUserAgent.swift
//  EnhancerKit
//
//  Created by 大帅 on 2023/4/18.
//

import Foundation
import AXVToolKit

public class FakeUserAgent {

    public enum BrowserType: String, CaseIterable {
        case chrome
        case opera
        case firefox
        case safari
        case edage
        case IE = "internet explorer"
    }

    public static var radomUserAgent: String {
        let allcases = BrowserType.allCases
        let browserIndex = arc4random_uniform(UInt32(allcases.count))
        var browserType: BrowserType = .chrome
        for (idx, ca) in allcases.enumerated() {
            if idx == browserIndex {
                browserType = ca
                break
            }
        }

        guard let UAList = UAJSONObject[browserType.rawValue], !UAList.isEmpty
        else { return "" }
        let index = arc4random_uniform(UInt32(UAList.count))
        return UAList[Int(index)]
    }

    public static let UAJSONObject: [String: [String]] = {
        let bundle = FakeUserAgent.bundle
        let json = bundle.axv.data(forResource: "browsers")
        return json?.axv.toJSONObject() as? [String: [String]] ?? [String: [String]]()
    }()

// swiftlint:disable convenience_type
    public static let bundle: Bundle = {
        let path = Bundle(for: FakeUserAgent.self).path(forResource: "FakeUserAgent", ofType: "bundle") ?? ""
        let bundle = Bundle(path: path) ?? Bundle(for: FakeUserAgent.self)
        return bundle
    }()
// swiftlint:enable convenience_type
}
