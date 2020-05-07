//
//  NewPostViewController.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/07.
//  Copyright © 2020 入江真礼. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {


    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var newPostTextField: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }

    private func setUpView(){
    }

    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapPostButton(_ sender: Any) {
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
