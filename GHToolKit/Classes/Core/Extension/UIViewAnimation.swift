//
//  UIViewAnimation.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/6/15.
//

import Foundation
import AXVToolKit
public extension AXVUIViewExtension {
    /// UI切换动画
    static func viewTransition(with targetView: UIView,
                               duration: TimeInterval = 0.3,
                               options: UIView.AnimationOptions = .showHideTransitionViews,
                               animations: @escaping () -> Void,
                               completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: targetView, duration: duration, options: options, animations: animations, completion: completion)
    }

}


