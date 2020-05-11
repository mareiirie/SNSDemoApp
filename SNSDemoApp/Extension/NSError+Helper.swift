//
//  NSError+Helper.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/11.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import Foundation

extension Error {

    private var ns: NSError {
        return self as NSError
    }

    /// オフラインかどうか
    var isOffline: Bool {
        return ns.domain == NSURLErrorDomain && ns.code == NSURLErrorNotConnectedToInternet
    }

    /// タイムアウトかどうか
    var isTimeout: Bool {
        return ns.domain == NSURLErrorDomain && ns.code == NSURLErrorTimedOut
    }

    /// タイムアウトかどうか
    var isCanceled: Bool {
        return ns.domain == NSURLErrorDomain && ns.code == NSURLErrorCancelled
    }
}
