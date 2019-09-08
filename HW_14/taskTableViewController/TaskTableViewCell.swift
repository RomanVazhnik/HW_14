//
//  TaskTableViewCell.swift
//  HW_14
//
//  Created by Роман Важник on 08/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var isComplitedView: UIView!
    
    func setupView(task: Task) {
        nameTextField.text = task.name
        let color = task.isComplit ? #colorLiteral(red: 0.4115961954, green: 0.731865285, blue: 0.3496421059, alpha: 1) : #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        isComplitedView.backgroundColor = color
    }
    

}
