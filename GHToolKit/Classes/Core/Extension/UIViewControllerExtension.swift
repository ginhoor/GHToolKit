//
//  UIViewControllerExtension.swift
//  GHViewKit
//
//  Created by 大帅 on 2022/7/18.
//

import Foundation
import AXVToolKit

public extension UIViewController {
    var gh: GHUIViewControllerExtension {
        return GHUIViewControllerExtension(self)
    }

    static var Gh: GHUIViewControllerExtension.Type {
        return GHUIViewControllerExtension.self
    }
}

public struct GHUIViewControllerExtension {
    internal let vc: UIViewController
    internal init(_ vc: UIViewController) {
        self.vc = vc
    }

    public func presentFullScreen(toVC: UIViewController, completion: (() -> Void)? = nil) {
        toVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen;
        toVC.isModalInPresentation = true
        vc.present(toVC, animated: true, completion: completion)
    }
}

public extension GHUIViewControllerExtension {
    func sampleAdjustForIpad(_ targetView: UIView, _ permittedArrowDirections: UIPopoverArrowDirection = .down) {
        if let popover = vc.popoverPresentationController {
            popover.sourceView = targetView
            if targetView.bounds == .zero {
                popover.sourceRect = CGRect(x: 0, y: 0, width: GlobalValue.screenWidth, height: GlobalValue.screenHeight)
            } else {
                popover.sourceRect = targetView.bounds
            }
            popover.permittedArrowDirections = permittedArrowDirections
        }
    }
}
