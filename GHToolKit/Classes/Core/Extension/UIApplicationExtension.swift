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

    @available(iOSApplicationExtension, unavailable)
    func openUrl(_ urlStr: String?, completion: ((Bool) -> Void)? = nil) {
        guard let string = urlStr, let url = URL(string: string) else {
            return
        }
        openUrl(url, completion: completion)
    }

    @available(iOSApplicationExtension, unavailable)
    func openUrl(_ url: URL, completion: ((Bool) -> Void)? = nil) {
        application.open(url, options: [:], completionHandler: completion)
    }

    @available(iOSApplicationExtension, unavailable)
    func openEmailSetting() {
        openUrl("MESSAGE://")
    }
}
