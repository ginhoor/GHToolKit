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
    func sampleAdjustForIpad(_ targetView: UIView, _ permittedArrowDirections: UIPopoverArrowDirection = .any) {
        if let popover = vc.popoverPresentationController {
            popover.sourceView = targetView
            if targetView.bounds == .zero {
                popover.sourceRect = CGRect(x: GlobalValue.screenWidth / 2, y: GlobalValue.screenHeight / 2, width: 0, height: 0)
            } else {
                popover.sourceRect = CGRect(x: targetView.bounds.width / 2, y: targetView.bounds.height / 2, width: 0, height: 0)
            }
            popover.permittedArrowDirections = permittedArrowDirections
        }
    }
}
