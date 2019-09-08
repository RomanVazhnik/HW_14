//
//  Extension + MainTableViewController.swift
//  HW_14
//
//  Created by Роман Важник on 08/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit

extension MainTableViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let index = textField.tag
        guard let text = textField.text, !text.isEmpty else { return }
        DataBaseManager.shared.editTask(newName: text, index: index)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}
