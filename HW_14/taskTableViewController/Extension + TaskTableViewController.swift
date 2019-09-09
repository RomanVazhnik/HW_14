//
//  Extension + TaskTableViewController.swift
//  HW_14
//
//  Created by Роман Важник on 08/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit

// Text Field Delegate
extension TasksTableViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let indexTask = textField.tag
        guard let text = textField.text, !text.isEmpty else { return }
        DataBaseManager.shared.editTaskInList(newTaskName: text, index: index, indexTask: indexTask)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}
