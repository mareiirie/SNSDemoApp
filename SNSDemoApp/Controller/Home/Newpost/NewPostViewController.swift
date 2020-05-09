//
//  NewPostViewController.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/07.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController {

    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var newPostTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    private func setUpView(){
    }

    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapPostButton(_ sender: Any) {
        let content = newPostTextField.text!
        let saveDocument = Firestore.firestore().collection("posts").document()
        guard let nowUser = UserDefaults.standard.dictionary(forKey: .nowLoginUser) else {
            fatalError("ログイン情報なし")
        }
        guard let nowUserId = nowUser["id"] else {
            fatalError("UserDefaultError")
        }
        saveDocument.setData([
            "content": content,
            "postID": saveDocument.documentID,
            "senderID": nowUserId,
            "createdAt": FieldValue.serverTimestamp(),
            "updatedAt": FieldValue.serverTimestamp()
        ]) { error in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
