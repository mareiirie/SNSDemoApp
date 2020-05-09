//
//  TimilineTableViewCell.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/09.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var contentsLabel: UILabel!

    var timelineData: Post? {

        didSet {
            guard let timelineData = timelineData else {
                return
            }

            contentsLabel.text = timelineData.content

        }
    }
}
