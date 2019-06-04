//
//  CreateTaskViewController.swift
//  TaskManagement
//
//  Created by Yoshiyuki Kato on 2019/05/09.
//  Copyright © 2019年 Yoshiyuki Kato. All rights reserved.
//

import Foundation
import UIKit

class CreateTaskViewController: UIViewController {
    
    fileprivate var createTaskView: CreateTaskView!
    
    fileprivate var dataSource: TaskDataSource!
    fileprivate var taskText: String?
    fileprivate var taskDeadline: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // CreateTaskViewを生成し、デリゲートにselfをセット
        createTaskView = CreateTaskView()
        createTaskView.delegate = self
        view.addSubview(createTaskView)
        
        // TaskDataSourceを生成
        dataSource = TaskDataSource()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        dataSource.loadData()
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // CreatTaskViewのレイアウトを決める
        createTaskView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.size.width -
                                        view.safeAreaInsets.left -
                                        view.safeAreaInsets.right,
                                      height: view.frame.size.height - view.safeAreaInsets.bottom)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // 保存が成功した時のアラート
    // 保存が成功したらアラートを出し、前の画面にもどる
    fileprivate func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in _ = self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // タスクが未入力時のアラート
    // タスクが未入力時に保存して欲しくない
    fileprivate func showMissingTaskTextAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    // 締め切り日が未入力の時のアラート
    // 締め切り日が未入力の時に保存して欲しくない
    fileprivate func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

// CreateTaskViewDelegateメソッド
extension CreateTaskViewController: CreateTaskViewDelegate {
    func createView(taskEditting view: CreateTaskView, text: String) {
        
        // タスク内容を入力しているときに呼ばれるデリゲートメソッド
        // CreateTaskiewからタスク内容を受け取りTaskTextに代入している
        taskText = text
    }
    
    func createView(deadlineEditting view: CreateTaskView, deadline: Date) {
        
        // 締め切り日時を入力している時に呼ばれるデリゲートメソッド
        // CreateTaskViewから締め切り日を受け取りtaskDeadlineに代入している
        taskDeadline = deadline
    }
    
    func createView(saveButtonDidTap view: CreateTaskView) {
        
        // 保存ボタンが押された時に呼ばれるデリゲートメソッド
        // taskTextがnilだった場合showMissingTaskTextを呼び、
        // taskDeadlineがnilだった場合showMissingTaskDeadlineAlert()を呼ぶ。
        // どちらもnilでなかった場合にtaskText, taskDeadlineからTaskを生成し、
        // dataSource.save(task: task)を呼んでtaskを保存している。
        // 保存完了後showSaveAlert()を呼ぶ。
        guard let taskText = taskText else {
            showMissingTaskTextAlert()
            return
        }
        let task = Task(text: taskText, deadline: taskDeadline!)
        dataSource.save(task: task)
        
        showSaveAlert()
    }
}
