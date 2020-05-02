//
//  FirebaseHandler.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/01.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit
import Firebase

class FirebaseAuthHandler: UIViewController {

    weak var delegate: FirebaseResultDelegate?

    func signUp(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
                    fatalError("")
                }
                self.switchErroeType(errorType: errcd)
            } else {
                guard let user = result?.user else {
                    fatalError("エラーハンドリングミス")
                }
                self.sendEmailVerification(to: user)
            }
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
                    fatalError("")
                }
                self.switchErroeType(errorType: errcd)
            } else {
                guard let user = result?.user else {
                    fatalError("エラーハンドリングミス")
                }
                self.delegate?.didSignInSucceed(user: user)
            }
        }
    }

    func sendEmailVerification(to user: User) {
        user.sendEmailVerification() { error in
            if let error = error {
                guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
                    fatalError("エラーハンドリングミス")
                }
                self.switchErroeType(errorType: errcd)
            } else {
                self.delegate?.didSignUpSucceed(message: "認証用のメールを送信しました")
            }
        }
    }

    func switchErroeType(errorType: AuthErrorCode){
        switch errorType {
        case .networkError:
            delegate?.didFailed(message: "ネットワークエラー")
        case .weakPassword:
            delegate?.didFailed(message: "パスワードが脆弱です")
        case .invalidEmail:
            delegate?.didFailed(message: "無効なEメール形式です")
        case .emailAlreadyInUse:
            delegate?.didFailed(message: "登録済みのEメールです")
        case .operationNotAllowed:
            delegate?.didFailed(message: "アカウントが無効です")
        case .userNotFound:
            delegate?.didFailed(message: "ユーザーが見つかりません")
        default:
            break
        }
    }
}
