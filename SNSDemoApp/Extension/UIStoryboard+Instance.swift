//
//  UIStoryboard+Instance.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/02.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

public extension UIStoryboard {

    class func viewController<T: UIViewController>(storyboardName: String,
                                                   identifier: String) -> T? {

        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(
            withIdentifier: identifier) as? T
    }
}
