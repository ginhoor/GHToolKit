//
//  GHSwiftUIContext.swift
//  GHToolKit
//
//  Created by 大帅 on 2023/6/8.
//

import Foundation
import SwiftUI
import AXVToolKit

public class GHSwiftUIContext {
    public static let shared = GHSwiftUIContext()
    private init() {}
}

public extension GHSwiftUIContext {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

    static var currentVC: UIViewController? {
        return UIViewController.Axv.currentViewController
    }

    @discardableResult
    static func presentView<T: View>(rootView: T, backgroundColor: UIColor = .clear, modalPresentationStyle: UIModalPresentationStyle = .overFullScreen, animated: Bool = false) -> UIHostingController<T>? {
        let vc = UIHostingController(rootView: rootView)
        vc.view.backgroundColor = backgroundColor
        vc.modalPresentationStyle = modalPresentationStyle
        guard let rootViewController = UIViewController.Axv.currentViewController else { return nil }
        rootViewController.present(vc, animated: animated)
        return vc
    }

    @discardableResult
    static func dismissCurrentVC(animated: Bool = false, completion: ()) -> Bool {
        guard let rootViewController = UIViewController.Axv.currentViewController else { return false }
        rootViewController.dismiss(animated: animated)
        return true
    }
}

public extension GHSwiftUIContext {
    static func insertView<T: View>(view: T, parentView: UIView, parentVC: UIViewController) -> UIHostingController<T> {
        let hostingController = UIHostingController(rootView: view)
        // 将 hostingController 添加到当前视图控制器中
        parentVC.addChild(hostingController)
        parentView.addSubview(hostingController.view)
        hostingController.didMove(toParent: parentVC)
        return hostingController
    }
}

public extension UIViewController {
    func insertView<T: View>(view: T, parentView: UIView) -> UIHostingController<T> {
        return GHSwiftUIContext.insertView(view: view, parentView: parentView, parentVC: self)
    }
}


public extension View {
    @ViewBuilder func ifIs<T>(_ condition: Bool, transform: (Self) -> T) -> some View where T: View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    @ViewBuilder func ifElse<T:View,V:View>( _ condition:Bool,isTransform:(Self) -> T,elseTransform:(Self) -> V) -> some View {
        if condition {
            isTransform(self)
        } else {
            elseTransform(self)
        }
    }
}
