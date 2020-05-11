//
//  ReturnCodeResult.swift
//  GnaviApp
//
//  Created by 入江真礼 on 2020/04/12.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

enum IndividualResult {
    case loading
    case success(T: Decodable)
    case unauthorized
    case failure(status: WebAPIReturnCode)
    case error(T: String)
}

protocol ReturnCodeResult: class {
    func returnCodeResult(returnCode: IndividualResult)
}
