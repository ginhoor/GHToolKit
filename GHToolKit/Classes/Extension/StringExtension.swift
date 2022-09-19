//
//  StringExtension.swift
//  GHToolKit
//
//  Created by 大帅 on 2022/5/31.
//

import Foundation
import CommonCrypto

public enum LanguageType: String, CaseIterable {
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

public extension String {
    static var GH: GHTKStringExtension.Type { return GHTKStringExtension.self }
    var gh: GHTKStringExtension { return GHTKStringExtension(self) }
}

public struct GHTKStringExtension {
    let str: String
    init(_ str: String) { self.str = str }
}

public extension GHTKStringExtension {

    static func systemLanguageFilePath(bundle: Bundle = Bundle.main) -> String? {
        let systemLanguage = Locale.preferredLanguages.first
        for type in LanguageType.allCases {
            if let systemLanguage = systemLanguage, systemLanguage.hasPrefix(type.rawValue) {
                return languageFilePath(type: type, bundle: bundle)
            }
        }
        return languageFilePath(bundle: bundle)
    }

    static func languageFilePath(type: LanguageType = .en, bundle: Bundle = Bundle.main) -> String? {
        if let path = bundle.path(forResource: type.rawValue, ofType:  "lproj") {
            return path
        }
        return bundle.path(forResource: LanguageType.en.rawValue, ofType: "lproj")
    }

    static func localized(_ bundle: Bundle = Bundle.main, table: String = "Localizable", _ key: String, _ args: CVarArg..., fallback value: String = "") -> String {
        let format = bundle.localizedString(forKey: key, value: value, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

public extension GHTKStringExtension {

    func widthToFit(font: UIFont, height: CGFloat) -> CGFloat {
        return widthToFit(attributes: [NSAttributedString.Key.font: font], height: height)
    }

    func widthToFit(attributes: [NSAttributedString.Key: Any], height: CGFloat) -> CGFloat {
        // swiftlint:disable line_length
        let rawValue = NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue | NSStringDrawingOptions.truncatesLastVisibleLine.rawValue
        // swiftlint:enable line_length
        let tempOptions = NSStringDrawingOptions(rawValue: rawValue)
        let size = NSString(string: str)
            .boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height),
                          options: tempOptions,
                          attributes: attributes,
                          context: nil).size
        return size.width
    }

    func heightToFit(font: UIFont, width: CGFloat) -> CGFloat {
        return heightToFit(attributes: [NSAttributedString.Key.font: font], width: width)
    }

    func heightToFit(attributes: [NSAttributedString.Key: Any], width: CGFloat) -> CGFloat {
        // swiftlint:disable line_length
        let tempOptions = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue | NSStringDrawingOptions.truncatesLastVisibleLine.rawValue)
        // swiftlint:enable line_length
        let size = NSString(string: str)
            .boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                          options: tempOptions,
                          attributes: attributes,
                          context: nil).size
        return size.height
    }
}

