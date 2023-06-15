//
//  GlobalValue+Ext.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/6/14.
//

import Foundation
import AXVToolKit

public extension GlobalValue {

    @available(iOSApplicationExtension, unavailable)
    static var safeAreaLeft: CGFloat {
        guard let window = UIView.Axv.currentWindow else { return 0 }
        return window.safeAreaInsets.left
    }

    @available(iOSApplicationExtension, unavailable)
    static var safeAreaRight: CGFloat {
        guard let window = UIView.Axv.currentWindow else { return 0 }
        return window.safeAreaInsets.right
    }
}
