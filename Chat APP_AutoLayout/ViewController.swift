//
//  ViewController.swift
//  Chat APP_AutoLayout
//
//  Created by 박균호 on 2020/03/04.
//  Copyright © 2020 박균호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 사용하려는 Cell 등록
        chatTableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "myCell")
        chatTableView.register(UINib(nibName: "YourCell", bundle: nil), forCellReuseIdentifier: "yourCell")
        
        // 키보드 관련 옵저버 - 상태를 알려주는 것
        // 키보드 올라올때
        // 키보드 내려올때
        //NotificationCenter.default.addObserver(self, selector: , name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
    
    func keyboardWillShow(noti: NotificationCenter){
        
    }
    
    @IBAction func sendString(_ sender: Any) {
    }
}

