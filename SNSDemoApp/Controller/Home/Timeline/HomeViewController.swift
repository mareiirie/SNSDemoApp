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
    var lastDocument: QueryDocumentSnapshot?
    var loadStatus = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        database = Firestore.firestore()
        setCells()
        timelineTableView.delegate = self
        timelineTableView.dataSource = timelineDatasource
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        database.collection("posts").order(by: "createdAt", descending: false).limit(toLast: 15).getDocuments { (snapshot, error) in
            if error == nil, let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let post = Post(data: data)
                    self.postArray.append(post)
                }
                self.lastDocument = snapshot.documents.first
                self.timelineDatasource.set(timelineData: self.postArray)
                self.timelineTableView.reloadData()
            }
        }
    }

    func setView(){
    }

    private func addOlderTimelineData(){
        if loadStatus {
            loadStatus = false
        guard let nextDocument = lastDocument else {
            return
        }
        database.collection("posts").order(by: "createdAt", descending: true).limit(to: 15).start(afterDocument: nextDocument).getDocuments { (snapshot, error) in
            if error == nil, let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let post = Post(data: data)
                    self.postArray.insert(post, at: 0)
                }
                self.lastDocument = snapshot.documents.last
                self.timelineDatasource.set(timelineData: self.postArray)
                self.timelineTableView.reloadData()
                self.loadStatus = true
            }
        }
        }else{
            return
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if timelineTableView.contentOffset.y + timelineTableView.frame.size.height > timelineTableView.contentSize.height && timelineTableView.isDragging {
            addOlderTimelineData()
        }
    }
}

extension HomeViewController: UITableViewDelegate {

}
