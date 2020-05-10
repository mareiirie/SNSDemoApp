//
//  HomeViewController.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/02.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var timelineTableView: UITableView!
    var database: Firestore!
    var postArray = [Post]()
    var timelineDatasource = TimeLineProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        setCells()
        timelineTableView.delegate = self
        timelineTableView.dataSource = timelineDatasource
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        database.collection("posts").order(by: "createdAt", descending: false).getDocuments { (snapshot, error) in
            if error == nil, let snapshot = snapshot {
                self.postArray = []
                for document in snapshot.documents {
                    let data = document.data()
                    let post = Post(data: data)
                    self.postArray.append(post)
                }
                self.timelineDatasource.set(timelineData: self.postArray)
                self.timelineTableView.reloadData()
            }
        }
    }

    private func setCells(){
        timelineTableView.register(UINib(nibName: TimelineTableViewCell.className, bundle: nil), forCellReuseIdentifier: TimelineTableViewCell.className)
        timelineTableView.register(UINib(nibName: EmptyTimelineTableViewCell.className, bundle: nil), forCellReuseIdentifier: EmptyTimelineTableViewCell.className)
    }

    @IBAction func tappedNewPostButton(_ sender: Any) {
        performSegue(withIdentifier: "toNewPost", sender: self)
    }

    class func instance() -> HomeViewController {
        guard let viewController = UIStoryboard.viewController(
            storyboardName: HomeViewController.className,
            identifier:  HomeViewController.className) as? HomeViewController else {
                fatalError("HomeViewController not Found.")
        }
        return viewController
    }
}

extension HomeViewController: UITableViewDelegate {

}
