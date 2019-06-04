//
//  TaskListCell.swift
//  TaskManagement
//
//  Created by Yoshiyuki Kato on 2019/05/05.
//  Copyright © 2019年 Yoshiyuki Kato. All rights reserved.
//

import Foundation
import UIKit

class TaskListCell: UITableViewCell {
    
    private var taskLabel: UILabel!
    private var deadlineLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // タスク内容
        taskLabel = UILabel()
        taskLabel.textColor = UIColor.black
        taskLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(taskLabel)
        
        // 締め切り日
        deadlineLabel = UILabel()
        deadlineLabel.textColor = UIColor.black
        deadlineLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(deadlineLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        taskLabel.frame = CGRect(x: 15.0,
                                 y: 15.0,
                                 width: contentView.frame.width - (15.0 * 2),
                                 height: 15.0)
        
        deadlineLabel.frame = CGRect(x: taskLabel.frame.origin.x,
                                     y: taskLabel.frame.maxY + 8.0,
                                     width: taskLabel.frame.width,
                                     height: 15.0)
    }
    
    // プロパティに値がセットされたときに呼ばれる
    var task: Task? {
        didSet {
            guard let t = task else {return}
            taskLabel.text = t.text
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            
            deadlineLabel.text = formatter.string(from: t.deadline)
        }
    }
}
