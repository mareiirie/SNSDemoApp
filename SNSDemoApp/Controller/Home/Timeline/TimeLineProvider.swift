//
//  TimeLineProvider.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/08.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit
import Firebase

final class TimeLineProvider: NSObject {

    fileprivate var timelineData = [Post]()

    func set(timelineData: [Post]) {
        self.timelineData = timelineData
    }
}

//MARK : - UITableViewDataSource
extension TimeLineProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timelineData.isEmpty ? 1 : timelineData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if timelineData.count == 0 {
            let cell = tableView
                .dequeueReusableCell(withIdentifier: EmptyTimelineTableViewCell.className,
                                     for: indexPath) as? EmptyTimelineTableViewCell
            return cell!
        } else {
            let cell = tableView
                .dequeueReusableCell(withIdentifier: TimelineTableViewCell.className,
                                     for: indexPath) as? TimelineTableViewCell
            cell?.timelineData = timelineData[timelineData.count - indexPath.row - 1]
            return cell!
        }
    }
}
