//
//  HomeAPI.swift
//  GnaviApp
//
//  Created by 入江真礼 on 2020/04/12.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import Alamofire

final class HomeAPI {

    weak var returnCodeResult: ReturnCodeResult?

    func fetch(format: String, title: String, applicationId: String) {

        let request = HomeRequest(format: format, title: title, applicationId: applicationId)

        self.returnCodeResult?.returnCodeResult(returnCode: .loading)

        APIClient.requestWithParameters(request: request) { response in

            switch response {
            case .success(let result):
                guard let result = result else {
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                guard let apiResult = try? decoder.decode(HomeResponse.self, from: result) else {
                    if let error = try? decoder.decode(HomeError.self, from: result) {
                        self.returnCodeResult?.returnCodeResult(returnCode: .error(T: error.error.message))
                    } else {
                        self.returnCodeResult?.returnCodeResult(returnCode: .failure(status: .other))
                    }
                    return
                }
                self.returnCodeResult?.returnCodeResult(returnCode: .success(T: apiResult))

            case .unauthorizedError:
                self.returnCodeResult?.returnCodeResult(returnCode: .unauthorized)
                break
            case .failure(let error):
                if error.isCanceled {
                    self.returnCodeResult?.returnCodeResult(returnCode: .failure(status: .cancel))
                    return
                }
                if error.isOffline || error.isTimeout {
                    self.returnCodeResult?.returnCodeResult(returnCode: .failure(status: .connectionFailure))
                    return
                }
                self.returnCodeResult?.returnCodeResult(returnCode: .failure(status: .other))
                break
            case .forbiddenError:
                self.returnCodeResult?.returnCodeResult(returnCode: .failure(status: .other))
                break
            }
        }
    }
}
