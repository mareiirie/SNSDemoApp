//
//  HomeViewController.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/02.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tappedNewPostButton(_ sender: Any) {
        performSegue(withIdentifier: "toNewPost", sender: self)
    }

    class func instance() -> HomeViewController {
        guard let viewController = UIStoryboard.viewController(
            storyboardName: HomeViewController.className,
            identifier:  HomeViewController.className) as? HomeViewController else {
                fatalError("HomeViewController not Found.")
        }
        return viewController
    }
}
