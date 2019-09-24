//
//  TaskDataSource.swift
//  TaskManagement
//
//  Created by Yoshiyuki Kato on 2019/05/04.
//  Copyright © 2019年 Yoshiyuki Kato. All rights reserved.
//

import Foundation

class TaskDataSource: NSObject{
    
    // Taskに一覧を保存するArray
    private var tasks = [Task]()
    
    override init() {
        super.init()
        loadData()
        //deleteData()
    }
    // UserDefaultsから保存したTask一覧を取得
    func loadData() {
        let userDefaults = UserDefaults.standard
        let taskDictionaries = userDefaults.object(forKey: "hoge") as? [[String: Any]]
        guard let t = taskDictionaries else {return}
        
        tasks.removeAll()
        for dic in t {
            let task = Task(from: dic)
            tasks.append(task)
        }
    }
    
    func deleteTask(id: String) {
        
        let tasks = self.tasks.filter ({ (taskDictionary) -> (Bool) in
            if taskDictionary.id != id {
            return true
            } else {
                return false
            }})

        var taskDictionaries = [[String: Any]]()
        for t in tasks {
            let taskDictionary:[String: Any] = ["id": t.id, "text": t.text, "deadline": t.deadline]
            taskDictionaries.append(taskDictionary)
        }
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(taskDictionaries, forKey: "hoge")
            userDefaults.synchronize()
        
            loadData()
    }
    
    // TaskをUserDefaultsに保存
    func save(task: Task){
        tasks.append(task)
        
        var taskDictionaries = [[String: Any]]()
        for t in tasks {
            let taskDictionary:[String: Any] = ["id": t.id, "text": t.text, "deadline": t.deadline]
            taskDictionaries.append(taskDictionary)
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(taskDictionaries, forKey: "hoge")
        userDefaults.synchronize()
    }
    
    // Taskの総数を返す(UITableViewのcellをカウントするため使用)
    func count() -> Int{
        return tasks.count
    }
    
    // 指定したindexに対するTaskを返す。indexにはUITableViewのindexPath.rowが来ることを想定
    func data(at index: Int) -> Task? {
        if tasks.count > index {
            return tasks[index]
        }
        return nil
    }
}

