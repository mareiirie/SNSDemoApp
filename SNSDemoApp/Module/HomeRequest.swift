//
//  HomeRequest.swift
//  GnaviApp
//
//  Created by 入江真礼 on 2020/04/12.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import Alamofire

final class HomeRequest: WebAPIRequestProtocol {
    var httpMethod = HTTPMethod.get
    var parameters: [String : Any] = [:]

    init(format: String, title: String, applicationId: String) {
        parameters = [
            "20170404?format" : String(format),
            "title": String(title),
            "applicationId": String(applicationId),
        ]
    }
}
