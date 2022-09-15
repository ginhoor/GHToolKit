//
//  UIApplicationExtension.swift
//  GHViewKit
//
//  Created by 大帅 on 2022/7/19.
//

import Foundation

public extension UIApplication {
    var gh: GHUIApplicationExtension {
        return GHUIApplicationExtension(self)
    }

    static var Gh: GHUIApplicationExtension.Type {
        return GHUIApplicationExtension.self
    }
}

public struct GHUIApplicationExtension {
    internal let application: UIApplication
    internal init(_ application: UIApplication) {
        self.application = application
    }
}


public extension GHUIApplicationExtension {
    func openUrl(_ urlStr: String?) {
        guard let string = urlStr, let url = URL(string: string) else {
            return
        }
        openUrl(url)
    }

    func openUrl(_ url: URL) {
        application.open(url, options: [:], completionHandler: nil)
    }


    func openEmailSetting() {
        openUrl("MESSAGE://")
    }
}
