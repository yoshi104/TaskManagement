//
//  TaskListViewController.swift
//  TaskManagement
//
//  Created by Yoshiyuki Kato on 2019/05/06.
//  Copyright © 2019年 Yoshiyuki Kato. All rights reserved.
//

import Foundation
import UIKit

final class TaskListViewController: UIViewController {
    
    var dataSource: TaskDataSource!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = TaskDataSource()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonTapped(_:)))
        navigationItem.rightBarButtonItem = barButton
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.loadData()       // 画面が表示されるたびにデータをロードする
        tableView.reloadData()      // データをロードした後tableViewを更新する
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: view.safeAreaInsets.left,
                                 y: view.safeAreaInsets.top,
                                 width: view.bounds.size.width,
                                 height: view.bounds.size.height - view.safeAreaInsets.bottom)
    }
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
        // タスク作成画面へ画面遷移
        let controller = CreateTaskViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return dataSource.count()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TaskListCell
            
            // indexPath.rowに応じたTaskを取り出す
            let task = dataSource.data(at: indexPath.row)
            
            // taskをcellに受け渡す
            cell.task = task
            return cell
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let normalAction = UIContextualAction(style: .normal,
//                                              title: "normal") { (action, view, completionHandler) in
//                                                completionHandler(true)
//        }
//        let destructiveAction = UIContextualAction(style: .destructive,
//                                                   title: "destructive") { (action, veiw, completionHandler) in
//                                                    // deleteTask()
//                                                    self.dataSource.deleteTask(id: self.dataSource.data(at: indexPath.row)!.id)
//                                                    completionHandler(true)
//        }
//        let configuration = UISwipeActionsConfiguration(actions: [normalAction, destructiveAction])
//        return configuration
//    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.dataSource.deleteTask(id: self.dataSource.data(at: indexPath.row)!.id)
            //self.dataSource.data.remove(at: indexPath.row)
            //UserDefaults.standard.set(dataSource, forKey: "hoge")
            //self.dataSource.save(task: self.dataSource.data(at: indexPath.row)!)
             tableView.reloadData()
        } else if editingStyle == .insert {
       }
    }
}
