//
//  GetClassName.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/02.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

protocol GetClassName {
}

extension GetClassName {
    static var className: String {

        return String(describing: self)
    }
}

extension NSObject: GetClassName { }
