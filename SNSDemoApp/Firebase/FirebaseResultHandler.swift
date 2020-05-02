//
//  FirebaseErrorHandler.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/01.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit
import Firebase

protocol FirebaseResultDelegate: class {
    func didFailed(message: String)
    func didSignUpSucceed(message: String)
    func didSignInSucceed(user: User)
}

extension FirebaseResultDelegate {
    func didFailed(message: String) {}
    func didSignUpSucceed(message: String) {}
    func didSignInSucceed(user: User) {}
}
