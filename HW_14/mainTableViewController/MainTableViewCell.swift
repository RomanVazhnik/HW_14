//
//  MainTableViewCell.swift
//  HW_14
//
//  Created by Роман Важник on 08/09/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet var textField: UITextField!
    @IBOutlet var countTextLabel: UILabel!
    
    func setValues(textForTextField: String, count: Int) {
        self.textField.text = textForTextField
        countTextLabel.text = String(count)
    }
    
}
