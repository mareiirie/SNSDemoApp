//
//  HomeResponse.swift
//  GnaviApp
//
//  Created by 入江真礼 on 2020/04/12.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

struct HomeResponse: Decodable {
    let rest: [RestInfo]
}

struct HomeError: Decodable {
    let error: HomeErrorDetail
}

struct RestInfo: Decodable {
    let name: String?
    let imageUrl: ImageUrl
    let address: String?
    let tel: String?
    let access: Access
    let budget: Int?

    func isUnder3000() -> Bool {
        if let budget = budget {
            return budget <= 3000
        } else {
            return false
        }
    }
}

struct HomeErrorDetail: Decodable {
    let code: Int
    let message: String
}

struct ImageUrl: Decodable {
    let shopImage1: String?
    let shopImage2: String?
}

struct Access: Decodable {
    let station: String?
}
