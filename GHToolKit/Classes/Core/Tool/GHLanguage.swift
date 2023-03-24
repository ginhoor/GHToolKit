//
//  GHLanguage.swift
//  GHToolKit
//
//  Created by 大帅 on 2022/11/11.
//

import Foundation

public class GHLanguage {
    public static let shared = GHLanguage()
    private init() {}

    public static var isEnglish: Bool {
        return Locale.current.languageCode?.hasPrefix("en") ?? false
    }

    public static var isChinese: Bool {
        return Locale.current.languageCode?.hasPrefix("zh") ?? false
    }
}
