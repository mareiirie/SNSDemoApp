//
//  GetAPIService.swift
//  GnaviApp
//
//  Created by 入江真礼 on 2020/04/12.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

class GetAPIService: NSObject {
    weak var delegate: GetAPIServiceDelegate?
    private let homeAPI = HomeAPI()
}

extension GetAPIService {

    func getHomeInfo(){
        homeAPI.returnCodeResult = self
        homeAPI.fetch(format: "json",title: "どうぶつ", applicationId: "1021961634768237233")
    }

}

extension GetAPIService {
    private func requestSuccessful(response: Decodable) {
        if let response = response as? HomeResponse {
            delegate?.finishReloadHomeInfo(data: response)
        }
    }
}

// MARK: - ReturnCodeResult
extension GetAPIService: ReturnCodeResult {
    func returnCodeResult(returnCode: IndividualResult) {
        switch returnCode {
        case .loading:
            break
        case .success(T: let result):
            switchAPIResult(result: result)
            break
        case .unauthorized:
            delegate?.unauthorized()
        case .failure(status: let returnCode):
            delegate?.error(status: returnCode)
        case .error(T: let errorMessage):
            delegate?.error(message: errorMessage)
        }
    }

    private func switchAPIResult(result: Decodable) {
        if let result = result as? HomeResponse {
            requestSuccessful(response: result)
        }
    }
}
