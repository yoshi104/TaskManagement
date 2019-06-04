//
//  Task.swift
//  TaskManagement
//
//  Created by Yoshiyuki Kato on 2019/05/03.
//  Copyright © 2019年 Yoshiyuki Kato. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    
    let text: String
    let deadline: Date
    
    // オブジェクトをbyte列に変換
    func encode(with aCorder: NSCoder) {
        aCorder.encode(text, forKey: "text")
        aCorder.encode(deadline, forKey: "deadline")
    }
    
    // byte列からオブジェクトを復元
    required init?(coder aDecorder: NSCoder) {
        text = aDecorder.decodeObject(forKey: "text") as! String
        deadline = aDecorder.decodeObject(forKey: "deadline") as! Date
    }
    
    init(text: String, deadline: Date) {
        self.text = text
        self.deadline = deadline
    }
    
    init(from dictionary: [String: Any]) {
        self.text = dictionary["text"] as! String
        self.deadline = Date()
    }
}


