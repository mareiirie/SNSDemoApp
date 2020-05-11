//
//  WebAPIReturnCode.swift
//  GnaviApp
//
//  Created by 入江真礼 on 2020/04/12.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

//MARK: - Protocol
protocol GetAPIServiceDelegate: class {
    // MARK: required
    func error(status: WebAPIReturnCode)
    func unauthorized()

    // MARK: optional
    func finishReloadHomeInfo(data: HomeResponse)
    func error(message: String)
}

extension GetAPIServiceDelegate {
    func finishReloadHomeInfo(data: HomeResponse) {}
    func error(message: String){}
}

//MARK: - Error code
enum WebAPIReturnCode: String {
    /// 通信失敗(オフライン、タイムアウト)
    case connectionFailure = "connectionFailure"
    /// キャンセル
    case cancel = "cancel"
    case other = "other"
    case disabledAccouont = "0001"
    case serverError = "0002"
    case dbError = "0003"
    case alreadyLogout = "0004"
    case alreadyCheckout = "0005"
    case noRecord = "0006"
    case processingFaild = "0007"

    var message: String {
        switch self {
        case .connectionFailure:
            return "通信失敗"
        case .cancel:
            return "cancel"
        case .other:
            return "サーバーの内部エラーが発生しています。"
        case .disabledAccouont:
            return "アカウント不正"
        case .serverError:
            return "サーバーエラー"
        case .dbError:
            return "データベースエラー"
        case .alreadyLogout:
            return "ログアウト済み"
        case .alreadyCheckout:
            return "チェックアウト済み"
        case .noRecord:
            return "レコードがない"
        case .processingFaild:
            return "処理に失敗した"
        }
    }

    func showAlertDialogOK(_ viewController: UIViewController,
                           okHandler: ((UIAlertAction) -> Void)? = nil) {

        showAlertDialogOKAndCancel(viewController, okHandler: okHandler)
    }

    func showAlertDialogOKAndCancel(_ viewController: UIViewController,
                                    okHandler: ((UIAlertAction) -> Void)? = nil,
                                    cancelHandler: ((UIAlertAction) -> Void)? = nil) {

        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)

        let okButton = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: okHandler)

        alert.addAction(okButton)

        if let cancelHandler = cancelHandler {
            let cancelButton = UIAlertAction(title: "ALERT_CANCEL",
                                             style: .cancel,
                                             handler: cancelHandler)

            alert.addAction(cancelButton)
        }
        viewController.present(alert, animated: true, completion: nil)
    }
}
