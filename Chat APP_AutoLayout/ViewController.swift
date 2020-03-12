//
//  ViewController.swift
//  Chat APP_AutoLayout
//
//  Created by 박균호 on 2020/03/04.
//  Copyright © 2020 박균호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!{
        didSet{
            chatTableView.delegate = self
            chatTableView.dataSource = self
//            chatTableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var inputTextView: UITextView!{
        didSet{
            inputTextView.delegate = self
        }
    }
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    @IBOutlet weak var inputTextViewHeight: NSLayoutConstraint!
    
    var chatDatas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 사용하려는 Cell 등록
        chatTableView.register(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "myCell")
        chatTableView.register(UINib(nibName: "YourCell", bundle: nil), forCellReuseIdentifier: "yourCell")
        
        // 키보드 관련 옵저버 - 상태를 알려주는 것
        // 키보드 올라올때
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow) , name: UIResponder.keyboardWillShowNotification, object: nil)
        // 키보드 내려올때
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide) , name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(noti: Notification){
        let notiInfo = noti.userInfo!
        let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        // 아래쪽 safearea만큼 빼준다.
        let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval// keyboard animation 시간
        UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(noti: Notification){
        let notiInfo = noti.userInfo!
        let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval// keyboard animation 시간
         UIView.animate(withDuration: animationDuration) {
            self.inputViewBottomMargin.constant = 0
            self.view.layoutIfNeeded()
       }
    }
    
    @IBAction func sendString(_ sender: Any) {
        chatDatas.append(inputTextView.text)
        inputTextView.text = ""
        let lastIndexPath = IndexPath(row: chatDatas.count - 1, section: 0)
        
        // tableview 전체가 갱신
        // chatTableView.reloadData()
        // tableview 마지막 row만 갱신
        chatTableView.insertRows(at: [lastIndexPath], with: UITableView.RowAnimation.automatic)
        
        inputTextViewHeight.constant = 40
        
        chatTableView.scrollToRow(at: lastIndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0{
            let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCell
            myCell.myCellTextView.text = chatDatas[indexPath.row]
            myCell.selectionStyle = .none
            return myCell
        }else{
            let yourCell = tableView.dequeueReusableCell(withIdentifier: "yourCell", for: indexPath) as! YourCell
            yourCell.yourCellTextView.text = chatDatas[indexPath.row]
            yourCell.selectionStyle = .none
            return yourCell
        }
    }
}
extension ViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height <= 40 {
            inputTextViewHeight.constant = textView.contentSize.height
        }else if textView.contentSize.height >= 100 {
            inputTextViewHeight.constant = 100
        }else {
            inputTextViewHeight.constant = textView.contentSize.height
        }
    }
}
