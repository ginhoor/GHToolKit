//
//  UIFont.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/6/9.
//

import Foundation
import UIKit


public extension UIFont {
    var gh: GHTKUIFontExt { return GHTKUIFontExt(self) }
    static var Gh: GHTKUIFontExt.Type { return GHTKUIFontExt.self }
}

public struct GHTKUIFontExt {
    internal let font: UIFont
    internal init(_ font: UIFont) { self.font = font }
}

public extension GHTKUIFontExt {

    static func preferredFont(for style: UIFont.TextStyle, weight: UIFont.Weight = .regular, italic: Bool = false) -> UIFont {
        // Get the style's default pointSize
        let traits = UITraitCollection(preferredContentSizeCategory: .large)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style, compatibleWith: traits)

        // Get the font at the default size and preferred weight
        var sysFont = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        if italic == true {
            sysFont = sysFont.gh.with([.traitItalic])
        }

        // Setup the font to be auto-scalable
        let metrics = UIFontMetrics(forTextStyle: style)
        return metrics.scaledFont(for: sysFont)
    }

    private func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = font.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(font.fontDescriptor.symbolicTraits)) else {
            return font
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
