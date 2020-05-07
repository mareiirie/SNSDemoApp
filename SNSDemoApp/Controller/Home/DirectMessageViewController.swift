//
//  DirectMessageViewController.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/07.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

class DirectMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    class func instance() -> DirectMessageViewController {
        guard let viewController = UIStoryboard.viewController(
            storyboardName: DirectMessageViewController.className,
            identifier:  DirectMessageViewController.className) as? DirectMessageViewController else {
                fatalError("DirectMessageViewController not Found.")
        }
        return viewController
    }
}
