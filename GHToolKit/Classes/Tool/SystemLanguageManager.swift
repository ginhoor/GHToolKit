//
//  UIApplicationExtension.swift
//  GHViewKit
//
//  Created by 大帅 on 2022/7/19.
//

import Foundation

public struct SystemLanguageManager {
    public enum Language: String, CaseIterable {
        case unknow = "unknow"
        case en = "en"  // 英语
        case ru = "ru"  // 俄语
        case pt = "pt-BR"  // 葡语
        case es = "es"  // 西语
        case fr = "fr"  // 法语
        case it = "it"  // 意大利语
        case th = "th"  // 泰语
        case cn_s = "zh-Hans"  // 中文简体
        case cn_t = "zh-Hant"  // 中文繁体
        case ja = "ja"  // 日语
        case de = "de"  // 德语
        case vi = "vi"  // 越南语
        case id = "id"  // 印尼语
    }
}

public extension SystemLanguageManager {
    static var currentLaguage: Language {
        guard let systemLanguage = Locale.preferredLanguages.first else {
            return Language.unknow
        }

        for temp in Language.allCases {
            if systemLanguage.hasPrefix(temp.rawValue) {
                return temp
            }
        }
        return Language.unknow
    }
}
