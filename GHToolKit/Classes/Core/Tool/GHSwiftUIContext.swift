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
    static func presentView<T>(rootView: T, backgroundColor: UIColor = .clear, modalPresentationStyle: UIModalPresentationStyle = .overFullScreen, animated: Bool = false) -> UIHostingController<T>? {
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
