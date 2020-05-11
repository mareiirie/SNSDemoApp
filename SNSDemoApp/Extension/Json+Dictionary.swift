//
//  Json+Dictionary.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/11.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

extension Dictionary {

    var prettyPrintedJsonString: String {
        do {
            if !JSONSerialization.isValidJSONObject(self) {
                log?.info(self)
                return "JSON Covert Failre."
            }
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(bytes: jsonData, encoding: .utf8) ?? "JSON Covert Failre."
        } catch {
            return "JSON Covert Failre."
        }
    }
}
