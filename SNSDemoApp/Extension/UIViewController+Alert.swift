//
//  UIViewController+Alert.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/01.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Warningダイアログを表示
    ///
    /// - Parameter message: メッセージ
    func showWarning(message: String) {
        let alert = AlertHelper.buildAlert(title: "Warning",
                                           message: message)
        present(alert, animated: false)
    }

    /// 確認ダイアログを表示
    ///
    /// - Parameters:
    ///   - message: メッセージ
    ///   - action: OKボタン押下時のアクション
    func showConfirm(message: String, action: ((UIAlertAction) -> Void)? = nil) {

        let alert = AlertHelper
            .buildAlert(title: "Confirm",
                        message: message,
                        leftButtonTitle: "Cancel",
                        rightButtonAction: action)
        present(alert, animated: false)
    }
}

final class AlertHelper {

    typealias AlertActionType = ((UIAlertAction) -> Void)

    static func buildAlert(title: String? = nil,
                           message: String,
                           rightButtonTitle: String = "OK",
                           leftButtonTitle: String? = nil,
                           rightButtonAction: AlertActionType? = nil,
                           leftButtonAction: AlertActionType? = nil) -> UIAlertController {

        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let positiveAction = UIAlertAction(title: rightButtonTitle,
                                           style: .default,
                                           handler: rightButtonAction)
        alert.addAction(positiveAction)

        if let leftButtonTitle = leftButtonTitle {
            let negativeAction = UIAlertAction(title: leftButtonTitle,
                                               style: .cancel,
                                               handler: leftButtonAction)
            alert.addAction(negativeAction)
        }
        return alert
    }
}
